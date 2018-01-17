# frozen_string_literal: true

class MoviesController < ApplicationController
  # GET /movies
  def index
    @movies = current_user.movies.includes(:primary_image).order(:release_year)
  end

  # GET /movie/:id
  def show
    @movie = current_user.movies.includes(:images).find(params[:id])
    @secondary_images = @movie.images.to_a
    @primary_image = @secondary_images.shift
  end

  # GET /movies/new
  def new
    @movie = current_user.movies.new
  end

  # POST /movies
  def create
    @movie = current_user.movies.new(permitted_params)

    if @movie.save
      flash[:notice] = I18n.t('movie.success_create_notice')
      redirect_to movie_path(@movie)
    else
      flash[:alert] = I18n.t('movie.fail_create_notice')
      render :new
    end
  end

  # GET /movies/:id/edit
  def edit
    @movie = current_user.movies.includes(:images).find(params[:id])
  end

  # PATCH /movies/:id
  def update
    @movie = current_user.movies.find(params[:id])

    if @movie.update(permitted_params)
      flash[:notice] = I18n.t('movie.success_update_notice')
      redirect_to movie_path(@movie)
    else
      flash[:error] = I18n.t('movie.fail_update_notice')
      render :edit
    end
  end

  # DELETE /movies/:id
  def destroy
    @movie = current_user.movies.find(params[:id])

    if @movie.destroy
      flash[:notice] = I18n.t('movie.success_delete_notice')
      redirect_to movies_path
    else
      flash[:alert] = I18n.t('movie.fail_delete_notice')
      redirect_to movie_path(@movie)
    end
  end

  # GET /movies/new_import
  def new_import
  end

  # POST /movies/import
  def import
    movie = ImportMovieService.new(name: params[:search_name], user: current_user).call

    if movie
      flash[:notice] = I18n.t('movie.success_import_notice')
      redirect_to movie_path(movie)
    else
      flash[:alert] = I18n.t('movie.fail_import_notice')
      render :new_import
    end
  end

  private

  def permitted_params
    params.required(:movie).permit(:name, :description, image_ids: [])
  end
end

