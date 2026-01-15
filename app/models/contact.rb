class Contact < ApplicationRecord
  after_create_commit :broadcast_refresh
  after_update_commit :broadcast_update_row
  after_destroy_commit :broadcast_destroy_row

  before_validation :normalize_data

  validates :name, :surname, :email, :category, presence: true
  validates :email, uniqueness: true
  validates :phone, format: {
    with: /\A\d{9}\z/,
    message: "has to include exact 9 numbers"
  }

  scope :by_category, ->(category) { where(category: category) if category.present? }

  enum :category, { family: 0, friends: 1, work: 2 }

  private

  def normalize_data
    self.name = normalize(name)
    self.surname = normalize(surname)
    self.phone = phone.to_s.gsub(/\D/, "")
  end

  def normalize(value)
    value.to_s.strip.capitalize # to_s used in case value is nil
  end

  def broadcast_refresh
    broadcast_replace_to "contacts",
                         target: "refresh_trigger",
                         html: "<div id='refresh_trigger' data-id='#{SecureRandom.uuid}'></div>"
  end

  def broadcast_update_row
    # Update will not submit the form so table order will be the same but row will be yellow
    broadcast_replace_to "contacts",
                         target: ActionView::RecordIdentifier.dom_id(self),
                         partial: "contacts/table_row",
                         locals: { contact: self }
  end

  def broadcast_destroy_row
    # Remove will not submit the form so if one contact left there will not be info "There is not contacts to show"
    broadcast_remove_to "contacts", target: ActionView::RecordIdentifier.dom_id(self)
  end
end
