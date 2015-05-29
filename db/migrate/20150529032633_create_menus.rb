class CreateMenus < ActiveRecord::Migration
  def change
    create_table :menus do |t|
      t.references :spot, index: true, foreign_key: true
      t.integer :sort, index: true 
      t.string :name
      t.string :description

      t.timestamps null: false
    end
  end
end
