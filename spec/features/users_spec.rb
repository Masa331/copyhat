RSpec.describe 'User in application', type: :feature do
  it 'logs in with email' do

    expect(page).to have_content 'Byl jste úspěšně přihlášen'
    expect(page).to have_link 'Odhlásit'
  end

  it 'logs out sucesfully' do

    expect(page).to have_content 'Byl jste úspěšně odhlášen'
    expect(page).to have_link 'Přihlásit'
  end
end
