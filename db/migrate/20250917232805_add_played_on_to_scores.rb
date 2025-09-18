class AddPlayedOnToScores < ActiveRecord::Migration[8.0]
  def change
    add_column :scores, :played_on, :date
  end
end
