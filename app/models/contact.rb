class Contact < ApplicationRecord
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
end
