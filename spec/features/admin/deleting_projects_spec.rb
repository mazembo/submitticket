require 'rails_helper'

feature "Deleting projects" do
  before do
    login_as(FactoryGirl.create(:user, :admin))
   
  end
  scenario "Deleting a project" do
    FactoryGirl.create(:project, name: "TextMate 2")

    visit "/"
    click_link "TextMate 2"
    click_link "Delete Project"

    expect(page).to have_content("Project has been successfully destroyed.")

    visit "/"

    expect(page).to have_no_content("TextMate 2")
  end
end

