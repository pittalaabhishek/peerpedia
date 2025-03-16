FactoryBot.define do
  factory :answer do
    body { "Ruby on Rails is a web framework." }
    association :user
    association :question
  end
end
