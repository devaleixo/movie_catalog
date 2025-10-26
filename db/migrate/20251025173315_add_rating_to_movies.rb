class AddRatingToMovies < ActiveRecord::Migration[8.0]
  def change
    add_column :movies, :rating, :decimal, precision: 3, scale: 1, default: 0.0
  end
end
