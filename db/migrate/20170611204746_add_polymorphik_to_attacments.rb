class AddPolymorphikToAttacments < ActiveRecord::Migration[5.1]
  def change
    add_reference :attachments, :attachable, index: true
    add_column :attachments, :attachable_type, :string
    add_index :attachments, :attachable_type
  end
end
