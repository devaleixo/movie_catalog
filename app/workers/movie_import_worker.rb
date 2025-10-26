class MovieImportWorker
  include Sidekiq::Worker

  sidekiq_options retry: 3

  def perform(import_status_id, csv_content, user_id)
    import_status = ImportStatus.find(import_status_id)
    user = User.find(user_id)

    import_status.start_processing!

    success_count = 0
    error_count = 0
    errors = []

    begin
      # Garantir encoding UTF-8 e remover BOM se existir
      csv_content = csv_content.force_encoding('UTF-8')
      csv_content = csv_content.sub("\xEF\xBB\xBF".force_encoding('UTF-8'), '') # Remove UTF-8 BOM
      
      csv_data = CSV.parse(csv_content, headers: true, encoding: 'UTF-8')
      total_rows = csv_data.size
      import_status.update!(total_rows: total_rows)

      csv_data.each_with_index do |row, index|
        begin
          # Criar filme a partir da linha do CSV
          movie = user.movies.build(
            title: row['title'],
            synopsis: row['synopsis'],
            release_year: row['release_year'].to_i,
            duration: row['duration'].to_i,
            director: row['director'],
            rating: row['rating']&.to_f
          )

          # Adicionar categorias se existirem
          if row['categories'].present?
            category_names = row['categories'].split('|').map(&:strip)
            categories = category_names.map do |name|
              Category.find_or_create_by(name: name)
            end
            movie.categories = categories
          end

          if movie.save
            success_count += 1
          else
            error_count += 1
            errors << "Linha #{index + 2}: #{movie.errors.full_messages.join(', ')}"
          end
        rescue => e
          error_count += 1
          errors << "Linha #{index + 2}: #{e.message}"
        end

        # Atualizar progresso a cada 10 registros
        if (index + 1) % 10 == 0
          import_status.update_progress!(
            processed: index + 1,
            success: success_count,
            errors: error_count
          )
        end
      end

      # Atualizar progresso final
      import_status.update_progress!(
        processed: total_rows,
        success: success_count,
        errors: error_count
      )

      # Salvar mensagens de erro se houver
      if errors.any?
        import_status.update!(error_messages: errors.join("\n"))
      end

      # Marcar como completo
      import_status.mark_completed!

      # Enviar email de notificação
      ImportMailer.import_completed(import_status).deliver_now
    rescue => e
      import_status.mark_failed!(e.message)
      ImportMailer.import_failed(import_status).deliver_now
      raise e
    end
  end
end
