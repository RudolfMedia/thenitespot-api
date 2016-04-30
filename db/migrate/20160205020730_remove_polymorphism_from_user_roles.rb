class RemovePolymorphismFromUserRoles < ActiveRecord::Migration

  def change
  	add_column :user_roles, :spot_id, :integer

    UserRole.find_each do |role|
      role.spot_id = role.resource_id
      role.save
    end

    remove_column :user_roles, :resource_id
    remove_column :user_roles, :resource_type

  	add_index :user_roles, :spot_id
  end

end
