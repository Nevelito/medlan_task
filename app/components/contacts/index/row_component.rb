module Contacts
  module Index
    class RowComponent < ViewComponent::Base
      def initialize(contact:, index:)
        @contact = contact
        @index = index
      end
    end
  end
end
