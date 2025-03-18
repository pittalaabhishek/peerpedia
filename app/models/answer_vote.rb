class AnswerVote < Vote
  belongs_to :answer, foreign_key: :answer_id
  validates :answer_id, presence: true
end