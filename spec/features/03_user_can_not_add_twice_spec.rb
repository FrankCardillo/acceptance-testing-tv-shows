require 'spec_helper'

# As an organized TV fanatic
# I want to receive an error message if I try to add the same show twice
# So that I don't have duplicate entries

# Acceptance Criteria:
# [] If the title is the same as a show that I've already added, the details are not saved to the csv
# [] If the title is the same as a show that I've already added, I will be shown an error that says "The show has already been added".
# [] If the details of the show are not saved, I will remain on the new form page

feature "user tries to add a new TV show, but one already exists with the same title" do

  scenario "unsuccessfully add a new show" do

    CSV.open('television-shows.csv', 'a') do |file|
      title = "Friends"
      network = "NBC"
      starting_year = "1994"
      synopsis = "Six friends living in New York city"
      genre = "Comedy"
      data = [title, network, starting_year, synopsis, genre]
      file.puts(data)
    end

    visit "/television_shows/new"

    fill_in "Title", with: "Friends"
    fill_in "Network", with: "NBC"
    fill_in "Starting Year", with: "1994"
    fill_in "Synopsis", with: "Six friends living in New York city."
    select "Comedy", from: "Genre"

    click_button "Add TV Show"

    expect(page).to have_content "The show has already been added"
    expect(page).to have_content "Title"
  end

  scenario "fails to add a show with valid information and stays on the same page" do
    visit "/television_shows/new"

    click_button "Add TV Show"

    expect(page).to have_content "Please fill in all required fields"
    expect(page).to have_content "Title"
  end
end
