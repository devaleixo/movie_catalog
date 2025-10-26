require "rails_helper"

RSpec.describe ImportMailer, type: :mailer do
  describe "import_completed" do
    let(:mail) { ImportMailer.import_completed }

    it "renders the headers" do
      expect(mail.subject).to eq("Import completed")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

  describe "import_failed" do
    let(:mail) { ImportMailer.import_failed }

    it "renders the headers" do
      expect(mail.subject).to eq("Import failed")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

end
