class Answer < ApplicationRecord
  belongs_to :user
  belongs_to :question
  has_many :comments, dependent: :destroy
  has_many :votes, dependent: :destroy

  validates :body, presence: true, length: { minimum: 1 }
  default_scope { order(created_at: :desc) }

  # Upvote an answer for a user
  def upvote(user)
    vote = self.votes.find_or_initialize_by(user: user)
    vote.value = 1
    vote.save
  end

  # Downvote an answer for a user
  def downvote(user)
    vote = self.votes.find_or_initialize_by(user: user)
    vote.value = -1
    vote.save
  end

  # UNvote an answer for a user
  def unvote(user)
    vote = self.votes.find_by(user: user)
    vote&.destroy
  end
end
