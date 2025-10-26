class ImportMailer < ApplicationMailer
  def import_completed(import_status)
    @import_status = import_status
    @user = import_status.user

    mail(
      to: @user.email,
      subject: "✅ Importação de Filmes Concluída - #{@import_status.filename}"
    )
  end

  def import_failed(import_status)
    @import_status = import_status
    @user = import_status.user

    mail(
      to: @user.email,
      subject: "❌ Erro na Importação de Filmes - #{@import_status.filename}"
    )
  end
end
