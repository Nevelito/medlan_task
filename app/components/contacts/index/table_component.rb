module Contacts
  module Index
    class TableComponent < ViewComponent::Base
      def initialize(contacts:)
        @contacts = contacts
      end
    end
  end
end
