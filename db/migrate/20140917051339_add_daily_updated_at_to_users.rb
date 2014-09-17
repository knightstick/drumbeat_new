class AddDailyUpdatedAtToUsers < ActiveRecord::Migration
  def change
    add_column :users, :daily_updated_at, :datetime
  end
end
