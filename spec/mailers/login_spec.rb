require "rails_helper"

RSpec.describe LoginMailer, type: :mailer do
  describe "login_link" do
    let(:user) { User.new(email: 'pdonat@seznam.cz') }
    let(:mail) { LoginMailer.login_link(user) }

    it 'renders the headers' do
      expect(mail.subject).to eq("Přihlašovací odkaz do Copyhat.cz")
      expect(mail.to).to eq(["pdonat@seznam.cz"])
      expect(mail.from).to eq(["from@example.com"])
    end
  end
end
