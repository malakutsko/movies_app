# frozen_string_literal: true

require 'rails_helper'

feature 'Users Registrations' do
  include Warden::Test::Helpers

  let(:user) { build(:user) }

  scenario 'User signs up' do
    # I land on the site
    visit root_path

    # And click the link to sign up
    click_on I18n.t('shared.navbar.sign_up')

    # I fill out the form, but forget to provide my last name
    fill_in 'user[first_name]', with: user.first_name
    fill_in 'user[email]', with: user.email
    password = Faker::Internet.password
    fill_in 'user[password]', with: password
    fill_in 'user[password_confirmation]', with: password

    # When I submit the form
    click_on I18n.t('devise.registrations.submit_button')

    # I see the validation error
    expect(page).to have_content I18n.t('errors.messages.blank')

    # And provide my last_name and type password again
    fill_in 'user[last_name]', with: user.last_name
    fill_in 'user[password]', with: password
    fill_in 'user[password_confirmation]', with: password

    # I submit the form again
    click_on I18n.t('devise.registrations.submit_button')

    # And expect to be on my dashboard
    expect(page).to have_content 'Hello world'
  end
end
