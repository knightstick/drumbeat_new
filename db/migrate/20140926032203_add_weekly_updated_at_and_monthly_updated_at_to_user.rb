class AddWeeklyUpdatedAtAndMonthlyUpdatedAtToUser < ActiveRecord::Migration
  def change
    add_column :users, :weekly_updated_at, :datetime
    add_column :users, :monthly_updated_at, :datetime
  end
end
