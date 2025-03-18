class Question < ApplicationRecord
  belongs_to :user
  has_many :answers
  has_and_belongs_to_many :topics
  has_many :question_votes, foreign_key: :question_id
  validates :body, presence: true, length: { minimum: 10 }
  default_scope { order(created_at: :desc) }

  # Upvote a question for a user
  def upvote(user)
    vote = question_votes.find_or_initialize_by(user: user)
    vote.upvote
  end

  # Downvote a question for a user
  def downvote(user)
    vote = question_votes.find_or_initialize_by(user: user)
    vote.downvote
  end

  # Unvote a question for a user
  def unvote(user)
    vote = question_votes.find_by(user: user)
    vote&.unvote
  end
end
