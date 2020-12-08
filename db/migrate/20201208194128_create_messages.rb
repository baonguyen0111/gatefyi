class CreateMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :messages do |t|
	    t.text :message
	    t.references :user, index: true
	    t.references :chat, index: true
	    t.boolean :read, default: false

	    t.timestamps
    end
  end
end
