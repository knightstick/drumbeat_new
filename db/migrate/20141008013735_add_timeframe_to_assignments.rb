class AddTimeframeToAssignments < ActiveRecord::Migration
  def change
    add_column :assignments, :timeframe, :string
  end
end
