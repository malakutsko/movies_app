# frozen_string_literal: true

require 'rails_helper'
require 'pry'

feature 'Movie' do
  include Warden::Test::Helpers

  let(:user) { create(:user) }

  before(:each) do
    login_as user, scope: :user
  end

  context "when doesn't exists yet" do
    let(:movie) { build(:movie_with_images, user: user) }

    scenario 'is created by user', js: true do
      # I land to root
      visit root_path

      # Click my movies nav link
      click_on I18n.t('shared.navbar.my_movies')

      # Click button to create a new movie
      click_on I18n.t('movies.index.create_new_movie')

      # I fill out the form but forget to upload an attachment
      fill_in 'movie[name]', with: movie.name
      fill_in 'movie[description]', with: movie.description
      click_on I18n.t('movies.new.submit')

      # I see validation error, suggesting to upload at least one image
      expect(page).to have_content(
        I18n.translate('errors.messages.at_least_count_images', count: Movie::MINIMUM_NUMBER_OF_IMAGES)
      )

      # I attach an image
      attach_file('movie_image[attachment][]', "#{Rails.root}/spec/support/attachments/sample_image.png")
      Fog.mock!
      wait_for_ajax

      # And when I submit the form again
      click_on I18n.t('movies.new.submit')

      # The movie is successfully created
      expect(page).to have_content(I18n.t('movie.success_create_notice'))
      expect(page).to have_content(movie.name)
    end
  end

  context 'when exists' do
    let!(:movie) { create(:movie_with_images, user: user) }

    scenario 'is updated by user' do
      # I visit an edit page of one of my movies
      visit edit_movie_path(movie)

      # And update the name of the movie
      new_name = Faker::Movie.quote
      fill_in 'movie[name]', with: new_name

      # When I submit the form
      click_on I18n.t('movies.edit.submit')

      # The movie is successfully updated
      expect(page).to have_content(I18n.t('movie.success_update_notice'))
      expect(page).to have_content(new_name)
    end

    scenario 'is deleted by user' do
      # I visit a show page of one of my movies
      visit movie_path(movie)

      # When I click delete button
      click_on I18n.t('movies.show.delete_movie')

      # The movie is successfully deleted
      expect(page).to have_content(I18n.t('movie.success_delete_notice'))
    end

    scenario 'is listed on movies index page' do
      # When I visit movies index page
      visit movies_path

      # I see my movie listed there
      expect(page).to have_content(movie.name)
    end
  end
end
