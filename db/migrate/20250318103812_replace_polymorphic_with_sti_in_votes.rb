class ReplacePolymorphicWithStiInVotes < ActiveRecord::Migration[8.0]
  def change
    # Remove polymorphic columns
    remove_column :votes, :votable_type
    remove_column :votes, :votable_id

    # Add STI-specific foreign key columns
    add_column :votes, :question_id, :bigint
    add_column :votes, :answer_id, :bigint

    # Add indexes for the new foreign keys
    add_index :votes, :question_id
    add_index :votes, :answer_id
  end
end
