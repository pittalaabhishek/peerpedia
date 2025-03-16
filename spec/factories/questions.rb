FactoryBot.define do
  factory :question do
    body { "What is Ruby on Rails?" }
    association :user
  end
end
