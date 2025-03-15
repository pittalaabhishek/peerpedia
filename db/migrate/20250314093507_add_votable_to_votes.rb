class AddVotableToVotes < ActiveRecord::Migration[8.0]
  def change
    add_column :votes, :votable_type, :string
    add_column :votes, :votable_id, :integer
  end
end
