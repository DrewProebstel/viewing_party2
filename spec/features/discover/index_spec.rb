require 'rails_helper'

RSpec.describe 'Discover Index Page' do
  before :each do
    @user = User.create(name: 'Drewb', email: 'Drew@testemail.com', password: "test", password_confirmation: "test", password: "test", password_confirmation: "test")
    visit "/login"

    fill_in "email", with: 'Drew@testemail.com'
    fill_in "password", with: 'test'
    click_button "Log In"
  end
    describe "button link paths" do
      it "has a button to discover top rated movies", :vcr do
        visit "users/discover"

        expect(page).to have_button("Discover Top Rated Movies")

        click_button("Discover Top Rated Movies")

        expect(current_path).to eq("/users/movies")
      end

      it "has a search field to find movies by title", :vcr do
        visit "users/discover"

        fill_in "search", with: "Shaw"
        click_button("Search")

        expect(current_path).to eq("/users/movies")
      end
  end
end
