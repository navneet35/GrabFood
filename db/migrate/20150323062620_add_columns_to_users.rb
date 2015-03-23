class AddColumnsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :uid, :string,after: :email
    add_column :users, :provider, :string,after: :uid
  end
end
