class AddReputationToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :reputation, :integer, default: 0
  end
end
