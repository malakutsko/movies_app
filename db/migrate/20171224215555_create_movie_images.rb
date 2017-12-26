class CreateMovieImages < ActiveRecord::Migration[5.1]
  def change
    create_table :movie_images do |t|
      t.integer :movie_id
      t.string :attachment
      t.string :attachment_content_type
      t.string :attachment_file_name
      t.string :attachment_file_size
      t.boolean :primary

      t.timestamps
    end
  end
end
