class AddPosterUrlToMovies < ActiveRecord::Migration[8.0]
  def change
    add_column :movies, :poster_url, :string
  end
end
