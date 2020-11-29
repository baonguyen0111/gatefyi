class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.text :content
      t.integer :upvotes
      t.integer :downvotes
      t.references :user
      t.references :article
      t.timestamps
    end
  end
end
