class CreateAssignments < ActiveRecord::Migration
  def change
  	drop_table :assignments
    create_table :assignments do |t|
      t.references :scorecard, index: true

      t.timestamps
    end
  end
end
