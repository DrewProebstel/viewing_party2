require 'rails_helper'

RSpec.describe "Dashboard Page" do
  before :each do
    @user = User.create(name: 'Drewb', email: 'Drew@testemail.com', password: "test", password_confirmation: "test", password: "test", password_confirmation: "test")
    visit "/login"

    fill_in "email", with: 'Drew@testemail.com'
    fill_in "password", with: 'test'
    click_button "Log In"
  end
  it 'has correct title' do
    visit "/users"

    expect(page).to have_content("Drewb's Dashboard")
  end

  it 'has a button to navigate to discover movie page', :vcr do
    user = User.create(name: 'Geddy', email: '2112@yyz.com', password: "test", password_confirmation: "test")
    visit "/users"
    click_button("Discover Movies")

    expect(current_path).to eq("/users/discover")
  end

  it 'shows all viewing parties the user is invited or hosting with details', :vcr do
    user1 = User.create(name: 'Geddy', email: '2112@yyz.com', password: "test", password_confirmation: "test")
    user3 = User.create(name: 'Neil', email: 'bytor@snowdog.com', password: "test", password_confirmation: "test")
    party1 = Party.create(start_time: '2022-05-10', duration: 147, host: @user.id, movie_id: 123, host_name: "Alex")
    party2 = Party.create(start_time: '2022-05-14', duration: 147, host: user1.id, movie_id: 124, host_name: "Neil")
    PartyUser.create(user_id: user1.id, party_id: party1.id )
    PartyUser.create(user_id: @user.id, party_id: party1.id )
    PartyUser.create(user_id: user3.id, party_id: party1.id )
    PartyUser.create(user_id: user1.id, party_id: party2.id )
    PartyUser.create(user_id: @user.id, party_id: party2.id )

    visit "/users"

    within "#invited" do
      expect(page).to have_content("Geddy")
      expect(page).to have_content("Drewb")
      expect(page).to have_content("No End")
      expect(page).to have_content("2022-05-14")

      expect(page).to_not have_content("The Lord of the Rings")
    end

    within "#hosting" do
      expect(page).to have_content("Geddy")
      expect(page).to have_content("Neil")
      expect(page).to have_content("The Lord of the Rings")
      expect(page).to have_content('2022-05-10')

      expect(page).to_not have_content("No End")
    end
  end

  it 'links to movie show page', :vcr do
    user1 = User.create(name: 'Geddy', email: '2112@yyz.com', password: "test", password_confirmation: "test")
    user3 = User.create(name: 'Neil', email: 'bytor@snowdog.com', password: "test", password_confirmation: "test")
    party1 = Party.create(start_time: '2022-05-10', duration: 147, host: @user.id, movie_id: 123, host_name: "Alex")
    party2 = Party.create(start_time: '2022-05-14', duration: 147, host: user1.id, movie_id: 124, host_name: "Neil")
    PartyUser.create(user_id: user1.id, party_id: party1.id )
    PartyUser.create(user_id: @user.id, party_id: party1.id )
    PartyUser.create(user_id: user3.id, party_id: party1.id )
    PartyUser.create(user_id: user1.id, party_id: party2.id )
    PartyUser.create(user_id: @user.id, party_id: party2.id )

    visit "/users"
    click_link("The Lord of the Rings")

    expect(current_path).to eq("/users/movies/123")
  end
end
