FactoryBot.define do
  factory :user do
    name { "John Doe" }
    email { "john@example.com" }
    password { "password" }
    bio { "A short bio about the user." }
  end
end
