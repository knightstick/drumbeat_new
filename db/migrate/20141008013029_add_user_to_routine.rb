class AddUserToRoutine < ActiveRecord::Migration
  def change
    add_reference :routines, :user, index: true
  end
end
