class CreateAssignments < ActiveRecord::Migration
  def change
    create_table :assignments do |t|
      t.references :scorecard, index: true

      t.timestamps
    end
  end
end
