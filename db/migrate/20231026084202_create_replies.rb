class CreateReplies < ActiveRecord::Migration[7.0]
  def change
    create_table :replies do |t|
      t.integer :user_id
      t.integer :post_id
      t.text :reply

      t.timestamps
    end
  end
end
