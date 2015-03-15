class AddForeignKeyToUserRoleMap < ActiveRecord::Migration
  def change
   execute <<-SQL
      ALTER TABLE user_role_maps
	ADD CONSTRAINT
        FOREIGN KEY (role_id)
        REFERENCES roles(id)
    SQL
  end
end
