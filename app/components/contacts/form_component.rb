module Contacts
  class FormComponent < ViewComponent::Base
    def initialize(contact:)
      @contact = contact
    end
  end
end
