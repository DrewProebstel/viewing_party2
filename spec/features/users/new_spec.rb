require 'rails_helper'

RSpec.describe "Registration Page" do
  it 'creates a new user' do
    user_count = User.all.length
    visit '/users/register'
    fill_in "Name", with: 'Drew'
    fill_in "Email", with: 'Drew@testemail.com'
    fill_in "Password", with: 'test123'
    fill_in "Password confirmation", with: 'test123'
    click_button "Register"
    expect(User.all.length).to eq(user_count+1)
  end

  it 'redirects to the user Dashboard' do
    visit '/users/register'
    fill_in "Name", with: 'Drew'
    fill_in "Email", with: 'Drew@testemail.com'
    fill_in "Password", with: 'test123'
    fill_in "Password confirmation", with: 'test123'
    click_button "Register"

    user = User.last
    expect(current_path).to eq("/users/#{user.id}")
  end

  it 'flashes an error with invalid credentials' do
    User.create(name: 'Drewb', email: 'Drew@testemail.com', password: "test", password_confirmation: "test")
    visit '/users/register'
    fill_in "Name", with: 'Drew'
    fill_in "Email", with: 'Drew@testemail.com'
    fill_in "Password", with: 'test123'
    fill_in "Password confirmation", with: 'test123'
    click_button "Register"

    expect(page).to have_content('Email has already been taken')
  end
end
