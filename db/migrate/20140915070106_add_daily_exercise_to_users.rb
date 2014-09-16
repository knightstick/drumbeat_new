class AddDailyExerciseToUsers < ActiveRecord::Migration
  def change
    add_column :users, :daily_exercise, :integer
  end
end
