require "rails_helper"

RSpec.describe Contacts::Index::TableComponent, type: :component do
  let(:contacts) do
    [
      Contact.new(id: 1, name: "Jan", surname: "Kowalski", email: "jan@test.com", phone: "123", category: "friends", updated_at: Time.current),
      Contact.new(id: 2, name: "Anna", surname: "Nowak", email: "anna@test.com", phone: nil, category: "family", updated_at: Time.current)
    ]
  end

  it "renders a table with all contacts" do
    rendered_component = render_inline(described_class.new(contacts: contacts))

    expect(rendered_component.text).to include("Jan")
    expect(rendered_component.text).to include("Kowalski")
    expect(rendered_component.text).to include("Anna")
    expect(rendered_component.text).to include("Nowak")
    expect(rendered_component.text).to include("friends")
    expect(rendered_component.text).to include("family")
  end

  it "renders info if contacts are empty" do
    rendered_component = render_inline(described_class.new(contacts: []))
    expect(rendered_component.text).to include("There is no contacts to show")
  end
end
