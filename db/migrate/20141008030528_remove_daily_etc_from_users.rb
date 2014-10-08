class RemoveDailyEtcFromUsers < ActiveRecord::Migration
  def up
  	remove_column :users, :daily_exercise
  	remove_column :users, :daily_updated_at
  	remove_column :users, :weekly_exercise
  	remove_column :users, :weekly_updated_at
  	remove_column :users, :monthly_exercise
  	remove_column :users, :monthly_updated_at
  end

  def down
    add_column :users, :daily_exercise, :integer
    add_column :users, :weekly_exercise, :integer
    add_column :users, :monthly_exercise, :integer
    add_column :users, :daily_updated_at, :datetime
    add_column :users, :weekly_updated_at, :datetime
    add_column :users, :monthly_updated_at, :datetime    
  end
end
