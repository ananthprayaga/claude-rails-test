class CreateIdeas < ActiveRecord::Migration[8.1]
  def change
    create_table :ideas do |t|
      t.string :title, null: false
      t.text :description
      t.string :category
      t.string :status, null: false, default: "brainstorming"
      t.integer :potential, null: false, default: 3
      t.string :target_market
      t.string :revenue_model
      t.text :notes
      t.boolean :starred, null: false, default: false

      t.timestamps
    end
    add_index :ideas, :status
    add_index :ideas, :category
  end
end
