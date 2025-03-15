class AnswerVote < Vote
  belongs_to :votable, class_name: 'Answer', foreign_key: 'votable_id'
end