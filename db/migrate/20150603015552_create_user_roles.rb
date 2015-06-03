class CreateUserRoles < ActiveRecord::Migration
  def change
    create_table :user_roles do |t|
      t.references :user, index: true, foreign_key: true
      t.references :resource, polymorphic: true, index: true
      t.integer :role

      t.timestamps null: false
    end
  end
end
