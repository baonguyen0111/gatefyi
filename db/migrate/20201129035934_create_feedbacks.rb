class CreateFeedbacks < ActiveRecord::Migration[6.0]
  def change
    create_table :feedbacks do |t|
      t.text :content
      t.boolean :resolved, default: false
      t.references :user
      t.timestamps
    end
  end
end
