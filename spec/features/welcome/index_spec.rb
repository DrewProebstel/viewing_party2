require 'rails_helper'

RSpec.describe "Landing Page" do
  before :each do
    @user = User.create(name: 'Drewb', email: 'Drew@testemail.com', password: "test", password_confirmation: "test", password: "test", password_confirmation: "test")
    visit "/login"

    fill_in "email", with: 'Drew@testemail.com'
    fill_in "password", with: 'test'
    click_button "Log In"
  end
  it 'displays title of application' do
    visit '/'
    expect(page).to have_content("Viewing Party")
  end

  it 'has button that links to create new user' do
    visit '/'

    click_button("Create New User")
  end


  it 'displays name of user' do

    drew = User.create!(name: "Drew Proebstel", email: "drew@turdmail.com", password: "test", password_confirmation: "test")
    alex = User.create!(name: "Zac Hazelwood", email: "zach@turdmail.com", password: "test", password_confirmation: "test")

    visit '/'

    expect(page).to have_content("drew@turdmail.com")
    expect(page).to have_content("zach@turdmail.com")

  end
end
