class AddRoutineToAssignments < ActiveRecord::Migration
  def change
    add_reference :assignments, :routine, index: true
  end
end
