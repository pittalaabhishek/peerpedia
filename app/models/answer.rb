class Answer < ApplicationRecord
  belongs_to :user
  belongs_to :question
  has_many :comments, dependent: :destroy
  has_many :answer_votes, foreign_key: :answer_id
  validates :body, presence: true, length: { minimum: 1 }
  default_scope { order(created_at: :desc) }

  # Upvote an answer for a user
  def upvote(user)
    vote = answer_votes.find_or_initialize_by(user: user)
    vote.upvote
  end

  # Downvote an answer for a user
  def downvote(user)
    vote = answer_votes.find_or_initialize_by(user: user)
    vote.downvote
  end

  # Unvote an answer for a user
  def unvote(user)
    vote = answer_votes.find_by(user: user)
    vote&.unvote
  end
end
