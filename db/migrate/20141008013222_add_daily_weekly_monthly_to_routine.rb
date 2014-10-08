class AddDailyWeeklyMonthlyToRoutine < ActiveRecord::Migration
  def change
    add_column :routines, :daily, :integer
    add_column :routines, :weekly, :integer
    add_column :routines, :monthly, :integer
  end
end
