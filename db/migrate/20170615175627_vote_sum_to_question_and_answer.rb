class VoteSumToQuestionAndAnswer < ActiveRecord::Migration[5.1]
  def change
    add_column :answers, :votes_sum, :integer, default: 0
    add_column :questions, :votes_sum, :integer, default: 0
  end
end
