# frozen_string_literal: true

class ImportMovieService
  def initialize(name:, user:)
    @name = name
    @user = user
  end

  def call
    omdb_movie = OmdbApi.search_by_name(@name)
    return nil unless omdb_movie

    movie = Movie.new(name: omdb_movie['Title'],
                      release_year: omdb_movie['Year'],
                      description: 'Description TODO',
                      user_id: @user.id)

    movie.save(validate: false)

    image = movie.images.new
    image.remote_attachment_url = omdb_movie['Poster']
    image.save

    movie
  end
end
