class AddImageUrlToExercises < ActiveRecord::Migration
  def change
    add_column :exercises, :image_url, :string
  end
end
