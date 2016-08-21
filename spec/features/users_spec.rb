require 'rails_helper'

RSpec.describe 'User in application' do
  it 'logs in with email' do
    visit root_path

    fill_in 'Přihlášení', with: 'test@email.cz'
    within 'form' do
      click_on 'Přihlásit'
    end

    expect(page).to have_content 'Na váš e-mail byl odeslán přihlašovací odkaz'

    mail = ActionMailer::Base.deliveries.last
    text_part = mail.body.parts.first.to_s
    token = /token=3D(.*)\r/.match(text_part)[1]

    visit sessions_create_path token: token

    expect(page).to have_content 'Byl jste úspěšně přihlášen'
    expect(page).to have_button 'Odhlásit'
  end

  it 'logs out sucesfully' do
    user = User.new(email: 'neco@test.cz')
    login(user)

    visit root_path

    click_on 'Odhlásit'

    expect(page).to have_content 'Byl jste úspěšně odhlášen'
    expect(page).to have_link 'Přihlásit'
  end
end
