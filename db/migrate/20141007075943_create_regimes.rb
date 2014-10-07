class CreateRegimes < ActiveRecord::Migration
  def change
    create_table :regimes do |t|
      t.references :user, index: true
      t.integer :daily
      t.integer :weekly
      t.integer :monthly

      t.timestamps
    end
  end
end
