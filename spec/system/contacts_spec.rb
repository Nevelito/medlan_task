require "rails_helper"

RSpec.describe "Contacts management", type: :system, js: true do
  before do
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
    expect(page).to have_text("Work")
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

  context "check if filter select works correctly" do
    before do
      create(:contact, name: "ronaldo", category: "work")
      create(:contact, name: "messi", category: "friends")
    end
    it "filters contacts by category" do
      visit contacts_path
      expect(page).to have_text("Ronaldo")
      expect(page).to have_text("Messi")

      find('select[name="category"]').select("Work")

      expect(page).to have_text("Ronaldo")
      expect(page).not_to have_text("Messi")

      find('select[name="category"]').select("Friends")

      expect(page).not_to have_text("Ronaldo")
      expect(page).to have_text("Messi")

      find('select[name="category"]').select("Family")

      expect(page).not_to have_text("Ronaldo")
      expect(page).not_to have_text("Messi")
    end
  end

  it "counts number of contacts correctly" do
    visit contacts_path
    expect(page).to have_text("Contacts list: 1")

    click_button "Delete"

    expect(page).to have_text("Contacts list: 0")
  end

  it "shows a new contact in another window automatically" do
    using_session(:joe) do
      visit contacts_path
      expect(page).to have_content("Contacts list:")
    end

    using_session(:salami) do
      visit new_contact_path
      fill_in "Name", with: "Messi"
      fill_in "Surname", with: "Messi"
      fill_in "Email", with: "messi@example.pl"
      fill_in "Phone", with: "987654321"
      select "Work", from: "Category"
      click_on "Save"
    end

    using_session(:joe) do
      expect(page).to have_content("Messi", wait: 5)
    end
  end

  it "updates contact in another window automatically" do
    using_session(:joe) do
      visit contacts_path
      expect(page).to have_content("Jane")
    end

    using_session(:salami) do
      visit contacts_path
      click_on "Edit"
      fill_in "Name", with: "Ronaldo"
      click_on "Save"
    end

    using_session(:joe) do
      expect(page).to have_content("Ronaldo", wait: 5)
      expect(page).not_to have_content("Jane")
    end
  end

  it "deletes contact in another window automatically" do
    using_session(:joe) do
      visit contacts_path
      expect(page).to have_content("Jane")
    end

    using_session(:salami) do
      visit contacts_path
      click_on "Delete"
    end

    using_session(:joe) do
      expect(page).not_to have_content("Jane")
    end
  end
end
