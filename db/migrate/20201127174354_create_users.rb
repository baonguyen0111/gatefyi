class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :provider
      t.string :uid
      t.text :displayname
      t.string :description
      t.boolean :show_profile, default: true 
      t.string :remember_token
      t.datetime :remember_created_at
      t.boolean :isInNL, default: false
      t.boolean :isAdmin, default: false
      t.timestamps null: false
      t.text :image, default: ""
    end
    add_index :users , :email,                unique: true
    add_index :users , [:uid, :provider] , unique: true

  end
end
