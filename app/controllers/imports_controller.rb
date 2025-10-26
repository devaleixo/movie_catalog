class ImportsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_import_status, only: [:show]

  def index
    @import_statuses = current_user.import_statuses.recent.page(params[:page]).per(10)
  end

  def new
    @import_status = ImportStatus.new
  end

  def create
    uploaded_file = params[:import_status][:file]

    unless uploaded_file
      redirect_to new_import_path, alert: 'Por favor, selecione um arquivo CSV.'
      return
    end

    # Ler o conteúdo do arquivo com encoding UTF-8
    csv_content = uploaded_file.read.force_encoding('UTF-8')

    # Criar registro de importação
    @import_status = current_user.import_statuses.create!(
      filename: uploaded_file.original_filename,
      status: 'pending'
    )

    # Enfileirar o job do Sidekiq
    MovieImportWorker.perform_async(@import_status.id, csv_content, current_user.id)

    redirect_to import_path(@import_status), 
                notice: 'Importação iniciada! Você receberá um email quando o processo for concluído.'
  end

  def show
    # Atualizar status via AJAX se estiver em processamento
  end

  private

  def set_import_status
    @import_status = current_user.import_statuses.find(params[:id])
  end
end
