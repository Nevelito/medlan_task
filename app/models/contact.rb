class Contact < ApplicationRecord
  enum :category, { family: 0, friends: 1, work: 2 }
end
