RSpec.describe 'User' do
  it 'receives email notification after form submission' do

    expect(email.from).to eq "info@copyhat.com"
    expect(email.subject).to eq "CopyHat: Odeslaný formulář"
    expect(email.body).to include "Jméno: Přemysl Donát"
    expect(email.body).to include "Email: pdonat@seznam.cz"
    expect(email.body).to include "Newsletter: Ano"
  end
end
