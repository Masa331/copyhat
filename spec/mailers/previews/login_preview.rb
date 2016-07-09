# Preview all emails at http://localhost:3000/rails/mailers/login
class LoginPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/login/login_link
  def login_link
    LoginMailer.login_link
  end

end
