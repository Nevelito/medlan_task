FactoryBot.define do
  factory :contact do
    name { "Jan" }
    surname { "Kowalski" }
    email { Faker::Internet.unique.email }
    phone { "123456789" }
    category { "work" }
  end
end
