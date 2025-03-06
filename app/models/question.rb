class Question < ApplicationRecord
  belongs_to :user
  has_many :answers
  has_and_belongs_to_many :topics

  validates :body, presence: true, length: { minimum: 10 }
  default_scope { order(created_at: :desc) }
end
