class Vote < ApplicationRecord
  belongs_to :user

  default_scope { order(created_at: :desc) }

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
