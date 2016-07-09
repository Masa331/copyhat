RSpec.describe 'User in collected data' do
  it 'browses collected data' do

    within '.form-table' do
      expect(page).to have_content "Jméno Email Newsletter"

      within 'tr' do
        expect(page).to have_content "Přemysl Donát pdonat@seznam.cz Ano"
      end
    end
  end
end
