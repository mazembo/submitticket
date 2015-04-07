require 'rails_helper'

RSpec.feature "Creating Tickets" do
   
  before do
    #login_as(user)
    user = FactoryGirl.create(:user)
    project = FactoryGirl.create(:project)
    assign_role!(user, :editor, project)
    login_as(user)
    visit '/'
    click_link project.name
    click_link "New Ticket"
    #message = "You need to sign in or sign up before continuing."
    #expect(page).to have_content(message)
    #fill_in "Name", with: user.name
    #fill_in "Password", with: user.password
    #click_button "Sign in"
    #click_link project.name
    #click_link "New Ticket"
  end

  scenario "Creating a ticket" do
    fill_in "Title", with: "Non-standards compliance"
    fill_in "Description", with: "My pages are ugly!"
    attach_file "File", "spec/fixtures/speed.txt"
    click_button "Create Ticket"

    expect(page).to have_content("Ticket has been created.")

    within "#ticket .asset" do
      expect(page).to have_content("speed.txt")
      # expect(page).to have_content("Created by test1@example.com")
    end
  end

  scenario "Creating a ticket without valid attributes fails" do
    click_button "Create Ticket"

    expect(page).to have_content("Ticket has not been created.")
    expect(page).to have_content("Title can't be blank")
    expect(page).to have_content("Description can't be blank")
  end

  scenario "Description must be longer than 10 characters" do
    fill_in "Title", with: "Non-standards compliance"
    fill_in "Description", with: "it sucks"
    click_button "Create Ticket"

    expect(page).to have_content("Ticket has not been created.")
    expect(page).to have_content("Description is too short")
  end
end