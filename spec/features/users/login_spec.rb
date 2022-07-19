require 'rails_helper'

RSpec.describe "Login Page" do
  it 'redirects to a users landing page after a successful login' do
    user = User.create(name: 'Drewb', email: 'Drew@testemail.com', password: "test", password_confirmation: "test")
    visit '/login'
    fill_in "Email", with: 'Drew@testemail.com'
    fill_in "Password", with: 'test'
    click_button "Log In"
    expect(current_path).to eq("/users/#{user.id}")
  end
end
