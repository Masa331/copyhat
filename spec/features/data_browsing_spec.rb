require 'rails_helper'

RSpec.describe 'User in collected data' do
  it 'browses collected data' do
    user = User.new(email: 'neco@test.cz')
    login(user)

    form = Form.create!(name: 'newsletter sign-up', user: user)
    email_field = FormInput.create!(form: form, title: 'E-mail', input_type: :text)
    name_field = FormInput.create!(form: form, title: 'Name', input_type: :text)
    FormInput.create!(form: form, title: 'Register', input_type: :submit)

    DataEntry.create(form: form,
                     inputs: { email_field.id => 'pdonat@seznam.cz', name_field.id => 'Premysl Donat'})
    DataEntry.create(form: form,
                     inputs: { email_field.id => 'nekdo@gmail.com', name_field.id => 'Petr Novak'})

    within '.form-table' do
      expect(page).to have_content "Jméno Email"

      within 'tr' do
        expect(page).to have_content 'Přemysl Donát pdonat@seznam.cz'
        expect(page).to have_content 'Petr Novák nekdo@gmail.com'
      end
    end
  end
end
