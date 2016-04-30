class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.references :imageable, polymorphic: true, index: true
      t.string :file
      t.boolean :primary, defeult: false

      t.timestamps null: false
    end
  end
end
