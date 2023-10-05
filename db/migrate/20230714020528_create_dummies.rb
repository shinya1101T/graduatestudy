class CreateDummies < ActiveRecord::Migration[7.0]
  def change
    create_table :dummies do |t|
      t.string :名前

      t.timestamps
    end
  end
end
