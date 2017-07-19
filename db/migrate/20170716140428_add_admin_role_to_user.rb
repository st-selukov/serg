class AddAdminRoleToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :admin, :bool, default: false, index: true
  end
end
