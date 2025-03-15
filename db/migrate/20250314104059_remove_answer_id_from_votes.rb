class RemoveAnswerIdFromVotes < ActiveRecord::Migration[6.1]
  def change
    remove_column :votes, :answer_id
  end
end