class Answer < ApplicationRecord
  belongs_to :user
  belongs_to :question
  has_many :comments, dependent: :destroy
  has_many :votes

  validates :body, presence: true, length: { minimum: 10 }
  default_scope { order(created_at: :desc) }
end
