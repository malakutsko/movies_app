# frozen_string_literal: true

class MoviesController < ApplicationController
  # GET /movies
  def index
    @movies = current_user.movies
  end

  # GET /movie/:id
  def show
    @movie = current_user.movies.find(params[:id])
  end

  # GET /movies/new
  def new
    @movie = current_user.movies.new
  end

  # POST /movies
  def create
    @movie = current_user.movies.new(permitted_params)

    if @movie.save
      flash[:notice] = 'Success'
      redirect_to movie_path(@movie)
    else
      flash[:error] = 'Was not able to save movie. See errors below'
      render :new
    end
  end

  # GET /movies/:id/edit
  def edit
    @movie = current_user.movies.find(params[:id])
  end

  # PATCH /movies/:id
  def update
    @movie = current_user.movies.find(params[:id])

    if @movie.update(permitted_params)
      flash[:notice] = 'Success'
      redirect_to movie_path(@movie)
    else
      flash[:error] = 'Was not able to save movie. See errors below'
      render :new
    end
  end

  # DELETE /movies/:id
  def destroy
    @movie = current_user.movies.find(params[:id])

    if @movie.destroy
      flash[:notice] = 'Success'
      redirect_to movies_path
    else
      flash[:error] = 'Was not able to delete this movie'
      redirect_to movie_path(@movie)
    end
  end

  private

  def permitted_params
    params.required(:movie).permit(:name, :description)
  end
end

