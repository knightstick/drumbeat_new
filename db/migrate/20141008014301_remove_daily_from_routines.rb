class RemoveDailyFromRoutines < ActiveRecord::Migration
  def up
  	remove_column :routines, :daily
  	remove_column :routines, :weekly
  	remove_column :routines, :monthly
  end

  def down
  	add_column :routines, :daily, :string
  	add_column :routines, :weekly, :string
  	add_column :routines, :monthly, :string
  end
end
