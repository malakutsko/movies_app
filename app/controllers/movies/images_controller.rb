# frozen_string_literal: true

module Movies
  class ImagesController < ApplicationController
    before_action :define_movie, only: :create

    # POST /movies/:movie_id/images
    def create
      @image = if @movie
                 @movie.images.create!(image_params)
               else
                 MovieImage.create!(image_params)
               end

      @presigned_post = S3PresignPost.new(
        path: @image.reload.attachment.path,
        content_type: @image.attachment_content_type
      ).call
    end

    # DELETE /movies/:movie_id/images/:id
    def destroy
      @image = MovieImage.find(params[:id])
      @image.destroy
    end

    # def make_primary
    # end

    private

    def define_movie
      @movie = current_user.movies.find(params[:movie_id]) unless params[:movie_id] == 'new'
    end

    def image_params
      { attachment_content_type: params[:content_type],
        attachment_file_size:    params[:file_size],
        attachment_file_name:    params[:file_name] }
    end
  end
end
