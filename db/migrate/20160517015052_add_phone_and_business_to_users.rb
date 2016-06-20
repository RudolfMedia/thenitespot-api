class AddPhoneAndBusinessToUsers < ActiveRecord::Migration
  def change
    add_column :users, :phone, :string
    add_column :users, :business, :boolean
  end
end
