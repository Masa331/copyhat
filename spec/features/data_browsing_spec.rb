require 'rails_helper'

RSpec.describe 'User in collected data' do
  it 'browses collected data' do
    user = User.create(email: 'neco@test.cz')
    login(user)

    form = Form.create!(name: 'newsletter sign-up', user: user)
    email_field = FormInput.create!(form: form, title: 'E-mail', input_type: :text)
    name_field = FormInput.create!(form: form, title: 'Name', input_type: :text)
    FormInput.create!(form: form, title: 'Register', input_type: :submit)

    DataEntry.create(form: form,
                     inputs: { email_field.id => 'pdonat@seznam.cz', name_field.id => 'Přemysl Donát'})
    DataEntry.create(form: form,
                     inputs: { email_field.id => 'nekdo@gmail.com', name_field.id => 'Petr Novák'})

    visit root_path
    click_on "Formuláře"
    click_on 'newsletter sign-up'

    within '.form-table' do
      expect(page).to have_content "E-mail Name"

      expect(page).to have_content 'pdonat@seznam.cz Přemysl Donát'
      expect(page).to have_content 'nekdo@gmail.com Petr Novák'
    end
  end
end
