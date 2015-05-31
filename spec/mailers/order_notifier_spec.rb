require "rails_helper"

RSpec.describe OrderNotifier, :type => :mailer do
  describe "customer" do
    let(:mail) { OrderNotifier.customer }

    it "renders the headers" do
      expect(mail.subject).to eq("Customer")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

  describe "kitchen" do
    let(:mail) { OrderNotifier.kitchen }

    it "renders the headers" do
      expect(mail.subject).to eq("Kitchen")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

end
