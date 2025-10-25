class RenameMovieCategoriesToCategoriesMovies < ActiveRecord::Migration[8.0]
  def change
    rename_table :movie_categories, :categories_movies
  end
end
