class AddTierToExercises < ActiveRecord::Migration
  def change
    add_column :exercises, :tier, :integer
  end
end
