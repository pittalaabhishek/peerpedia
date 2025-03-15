class QuestionVote < Vote
  belongs_to :votable, class_name: 'Question', foreign_key: 'votable_id'
end