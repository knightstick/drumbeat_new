class AddWeeklyExerciseAndMonthlyExerciseToUser < ActiveRecord::Migration
  def change
    add_column :users, :weekly_exercise, :integer
    add_column :users, :monthly_exercise, :integer
  end
end
