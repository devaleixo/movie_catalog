class RemovePosterUrlFromMovies < ActiveRecord::Migration[7.1]
  def change
    remove_column :movies, :poster_url, :string
  end
end