module FeatureMacros
  def login(user)
    visit new_login_path
    fill_in 'Přihlášení', with: user.email
    within 'form' do
      click_on 'Přihlásit'
    end

    mail = ActionMailer::Base.deliveries.last
    text_part = mail.body.parts.first.to_s
    token = /token=3D(.*)\r/.match(text_part)[1]

    visit sessions_create_path token: token
  end
end
