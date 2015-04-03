require 'rails_helper'

RSpec.feature "Editing Projects" do
  let(:user) { FactoryGirl.create(:user)}
  let(:project) { FactoryGirl.create(:project)}
  
  before do
    assign_role!(user, :manager, project)
    login_as(user)

    visit "/"
    click_link project.name
    click_link "Edit Project"
  end

  scenario "Updating a project" do
    fill_in "Name", with: "TextMate 2 beta"
    click_button "Update Project"

    expect(page).to have_content("Project has been updated.")
  end

  scenario "Updating a project with invalid attributes is bad" do
    fill_in "Name", with: ""
    click_button "Update Project"

    expect(page).to have_content("Project has not been updated.")
  end
end