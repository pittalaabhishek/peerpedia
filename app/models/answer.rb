class Answer < ApplicationRecord
  belongs_to :user
  belongs_to :question
  has_many :comments
  has_many :votes

  validates :body, presence: true, length: { minimum: 10 }
end
