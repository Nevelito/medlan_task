require "rails_helper"

RSpec.describe Contacts::FormComponent, type: :component do
  it "renders full form labels and locals" do
    rendered_component = render_inline(described_class.new(contact: Contact.new))

    expect(rendered_component.text).to include("Name")
    expect(rendered_component.text).to include("Surname")
    expect(rendered_component.text).to include("Email")
    expect(rendered_component.text).to include("Category")
    expect(rendered_component.text).to include("Phone")
    expect(rendered_component.css('input[type="submit"]').attr('value').value).to eq("Save")
    expect(rendered_component.text).to include("Cancel")
  end
end
