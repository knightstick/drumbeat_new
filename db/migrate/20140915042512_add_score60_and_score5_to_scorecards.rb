class AddScore60AndScore5ToScorecards < ActiveRecord::Migration
  def change
    add_column :scorecards, :score60, :integer
    add_column :scorecards, :score5, :integer
  end
end
