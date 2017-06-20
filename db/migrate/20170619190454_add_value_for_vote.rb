class AddValueForVote < ActiveRecord::Migration[5.1]
  def change
    add_column :votes, :vote_value, :integer
  end
end
