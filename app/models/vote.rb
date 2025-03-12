class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :answer

  # Upvote an answer for a user
  def self.upvote(answer, user)
    vote = answer.votes.find_or_initialize_by(user: user)
    vote.value = 1
    vote.save
  end

  # Downvote an answer for a user
  def self.downvote(answer, user)
    vote = answer.votes.find_or_initialize_by(user: user)
    vote.value = -1
    vote.save
  end
end
