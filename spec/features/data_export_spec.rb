RSpec.describe 'User in data export' do
  it 'exports data in csv' do

    expect(csv).to eq expected_csv
  end
end
