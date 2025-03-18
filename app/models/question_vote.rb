class QuestionVote < Vote
  belongs_to :question, foreign_key: :question_id
  validates :question_id, presence: true
end
