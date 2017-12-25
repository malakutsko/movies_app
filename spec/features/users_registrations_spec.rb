# frozen_string_literal: true

require 'rails_helper'

feature 'Users Registrations' do
  include Warden::Test::Helpers

  let(:new_user) { build(:user) }
  let(:current_user) { create(:user) }

  scenario 'User signs up' do
    # I land on the site
    visit root_path

    # And click the link to sign up
    click_on I18n.t('shared.navbar.sign_up')

    # I fill out the form, but forget to provide my last name
    fill_in 'user[first_name]', with: new_user.first_name
    fill_in 'user[email]', with: new_user.email
    password = Faker::Internet.password
    fill_in 'user[password]', with: password
    fill_in 'user[password_confirmation]', with: password

    # When I submit the form
    click_on I18n.t('devise.registrations.submit_button')

    # I see the validation error
    expect(page).to have_content I18n.t('errors.messages.blank')

    # And provide my last_name and type password again
    fill_in 'user[last_name]', with: new_user.last_name
    fill_in 'user[password]', with: password
    fill_in 'user[password_confirmation]', with: password

    # I submit the form again
    click_on I18n.t('devise.registrations.submit_button')

    # And expect to be on my dashboard
    expect(page).to have_content 'Hello world'
  end

  scenario 'User updates their account' do
    # I am logged in
    login_as current_user, scope: :user

    # I visit my account settings
    visit edit_user_registration_path

    # When I try to delete mandatory field
    fill_in 'user[first_name]', with: ''
    click_on I18n.t('devise.registrations.update')

    # I see validation error
    expect(page).to have_content(I18n.t('errors.messages.blank'))

    # When I update my data
    new_first_name = Faker::Name.first_name
    fill_in 'user[first_name]', with: new_first_name
    click_on I18n.t('devise.registrations.update')

    # I see updated data in the navbar
    expect(page).to have_content(
      I18n.t('shared.navbar.signed_in_as', name: [new_first_name, current_user.last_name].join(' '))
    )
  end

  scenario 'User deletes their account' do
    # I am logged in
    login_as current_user, scope: :user

    # I visit my account settings
    visit edit_user_registration_path

    # When I delete my account
    click_on I18n.t('devise.registrations.cancel_my_account')

    # I am successfully redirected to root
    expect(current_path).to eq(root_path)

    # And I'm not signed in any more
    expect(page).to_not have_content(I18n.t('shared.navbar.logout'))
  end
end
