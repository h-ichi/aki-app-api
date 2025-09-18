# db/migrate/20250918000000_create_scores.rb
class CreateScores < ActiveRecord::Migration[8.0]
  def change
    create_table :scores do |t|
      t.integer :level, null: false
      t.float :remaining_time, null: false
      t.date :played_on, null: false 

      t.timestamps
    end

    add_index :scores, [:level, :played_on]
  end
end
