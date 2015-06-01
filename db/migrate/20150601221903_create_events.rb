class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.references :spot, index: true, foreign_key: true
      t.string :name
      t.string :slug, index: true 
      t.text :about
      t.string :age
      t.string :entry
      t.string :entry_fee
      t.string :phone
      t.string :email
      t.string :ticket_url
      t.string :website_url
      t.string :facebook_url 
      t.string :twitter_url

      t.timestamps null: false
    end

  end
end
