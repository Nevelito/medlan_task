require "rails_helper"

RSpec.describe "Contacts management", type: :system do
  before do
    driven_by(:rack_test)
    create(:contact, name: "Jane", surname: "Doe")
  end

  it "creates a new contact" do
    visit contacts_path
    click_link "Add contact"

    fill_in "Name", with: "Jan"
    fill_in "Surname", with: "Kowalski"
    fill_in "Email", with: "jan@test.com"
    fill_in "Phone", with: "123456789"
    select "Work", from: "Category"

    click_button "Save"

    expect(page).to have_text("Jan")
    expect(page).to have_text("Kowalski")
    expect(page).to have_text("jan@test.com")
    expect(page).to have_text("work")
  end

  it "updates an existing contact" do
    visit contacts_path
    expect(page).to have_text("Jane")
    expect(page).to have_text("Doe")
    click_link "Edit"

    fill_in "Name", with: "Simon"

    click_button "Save"

    expect(page).to have_text("Simon")
    expect(page).not_to have_text("Jane")
  end
end
