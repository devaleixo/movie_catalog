# Preview all emails at http://localhost:3000/rails/mailers/import_mailer
class ImportMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/import_mailer/import_completed
  def import_completed
    ImportMailer.import_completed
  end

  # Preview this email at http://localhost:3000/rails/mailers/import_mailer/import_failed
  def import_failed
    ImportMailer.import_failed
  end

end
