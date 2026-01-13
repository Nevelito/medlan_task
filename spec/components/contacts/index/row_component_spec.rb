require "rails_helper"

RSpec.describe Contacts::Index::RowComponent, type: :component do
  let(:contact) { Contact.new(id: 1, name: "Jan", surname: "Kowalski", email: "jan@test.com", phone: "123", category: "friends", updated_at: Time.current) }

  it "renders contact data correctly" do
    rendered_component = render_inline(described_class.new(contact: contact, index: 0))

    expect(rendered_component.text).to include("Jan")
    expect(rendered_component.text).to include("Kowalski")
    expect(rendered_component.text).to include("jan@test.com")
    expect(rendered_component.text).to include("123")
    expect(rendered_component.text).to include("friends")
    expect(rendered_component.text).to include("Delete")
    expect(rendered_component.text).to include("Edit")
  end
end
