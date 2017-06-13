class AddAtachmentToFile < ActiveRecord::Migration[5.1]
  def change
    add_column :attachments, :file, :string
  end
end
