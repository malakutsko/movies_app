class AddReleaseYearToMovies < ActiveRecord::Migration[5.1]
  def change
    add_column :movies, :release_year, :string
  end
end
