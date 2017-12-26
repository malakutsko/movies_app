# frozen_string_literal: true

require 'rails_helper'
require 'capybara/email/rspec'

feature 'Users Passwords' do
  let(:user) { create(:user) }

  scenario 'User recovers password' do
    # I'm on sign in page
    visit new_user_session_path

    # I click forgot password link
    click_on I18n.t('devise.passwords.forgot_your_password')

    # I provide my email and submit the form
    fill_in 'user[email]', with: user.email
    click_on I18n.t('devise.passwords.send_reset_password_instructions')

    # I receive an email and click link there
    open_email(user.email)
    current_email.click_link(I18n.t('devise.passwords.change_my_password'))

    # I see form to update the password and fill it in
    my_new_password = Faker::Internet.password
    fill_in 'user[password]', with: my_new_password
    fill_in 'user[password_confirmation]', with: my_new_password
    click_on I18n.t('devise.passwords.change_my_password')

    # I'm signed in successfully
    expect(page).to have_content(
      I18n.t('shared.navbar.signed_in_as', name: [user.first_name, user.last_name].join(' '))
    )
  end
end
