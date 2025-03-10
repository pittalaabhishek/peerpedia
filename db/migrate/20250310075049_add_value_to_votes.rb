class AddValueToVotes < ActiveRecord::Migration[8.0]
  def change
    add_column :votes, :value, :integer, default: 0
  end
end
