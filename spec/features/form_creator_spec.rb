RSpec.describe 'User in form creation' do
  it 'creates new form' do

    expect(page).to have_content 'Newsletter formulář'
  end

  it 'deletes from' do

    expect(page).to have_no_content 'Newsletter formulář'
  end

  it 'updates form' do

    expect(page).to have_content 'Newsletter formulář'
  end
end
