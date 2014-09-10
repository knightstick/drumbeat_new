class CreateScorecards < ActiveRecord::Migration
  def change
    create_table :scorecards do |t|
      t.references :user, index: true
      t.references :exercise, index: true
      t.integer :score4

      t.timestamps
    end
  end
end
