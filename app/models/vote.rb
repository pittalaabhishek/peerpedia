class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :votable, polymorphic: true

  # Common methods for all votes
  def upvote
    update(value: 1)
  end

  def downvote
    update(value: -1)
  end

  def unvote
    destroy
  end
end
