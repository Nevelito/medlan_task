require 'rails_helper'

RSpec.describe Contact, type: :model do
  before do
    create(:contact)
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:surname) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:category) }

    it 'allows only valid categories' do
      expect(build(:contact, category: 'work')).to be_valid
      expect { build(:contact, category: 'invalid') }.to raise_error(ArgumentError)
    end

    it { should validate_uniqueness_of(:email) }
  end

  describe 'callbacks' do
    let(:contact) { create(:contact, name: 'anna', surname: 'nowak') }

    it 'capitalizes name and surname before saving' do
      expect(contact.name).to eq('Anna')
      expect(contact.surname).to eq('Nowak')
    end
  end

  describe 'database constraints' do
    it 'prevents saving nil values for required fields' do
      contact = build(:contact, name: nil)
      expect(contact.save).to eq(false)
      expect(contact.errors[:name]).to include("can't be blank")
    end
  end

  describe 'email uniqueness' do
    let!(:existing_contact) { create(:contact, email: 'test@example.com') }

    it 'does not allow duplicate email' do
      contact = build(:contact, email: 'test@example.com')
      expect(contact).not_to be_valid
      expect(contact.errors[:email]).to include('has already been taken')
    end
  end

  describe "broadcasting" do
    include ActionCable::TestHelper

    it "broadcasts a refresh signal after create" do
      expect {
        create(:contact)
      }.to have_broadcasted_to("contacts").with { |data|
        expect(data).to include("refresh_trigger")
      }
    end

    it "broadcasts a row update after update" do
      contact = create(:contact)

      expect {
        contact.update!(name: "Ronaldo")
      }.to have_broadcasted_to("contacts").with { |data|
        expect(data).to include("tr id=\"contact_#{contact.id}\"")
      }
    end
  end
end
