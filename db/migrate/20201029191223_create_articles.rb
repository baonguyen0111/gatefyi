class CreateArticles < ActiveRecord::Migration[6.0]
  def change
    create_table :articles do |t|
      t.string :company
      t.string :industry_type
      t.string :state
      t.string :city
      t.integer :compensation
      t.text :interview_exp
      t.text :work_exp
      t.integer :upvotes
      t.boolean :admin_approved, default: false
      t.datetime :approved
      t.references :user
      t.timestamps
    end
  end
end
