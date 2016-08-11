require 'rails_helper'

RSpec.describe 'User in data export' do
  let(:expected_csv) { File.read(Rails.root.join('spec', 'fixtures', 'data_entries.csv')) }

  it 'exports data in csv' do

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

    click_on 'Stáhnout v csv'

    expect(page.body).to eq expected_csv
  end
end
