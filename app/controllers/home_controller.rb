# frozen_string_literal: true

class HomeController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    if current_user
      @your_recent_movies = current_user.movies.includes(:primary_image).recent
      @other_recent_movies = Movie.includes(:primary_image).where.not(user_id: current_user.id)
    else
      @other_recent_movies = Movie.includes(:primary_image).recent
    end
  end
end
