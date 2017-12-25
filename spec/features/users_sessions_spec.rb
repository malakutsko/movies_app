# frozen_string_literal: true

require 'rails_helper'

feature 'Users Sessions' do
  include Warden::Test::Helpers

  let(:user) { create(:user) }

  scenario 'User signs in' do
    # I land on the site
    visit root_path

    # And click the link to sign in
    click_on I18n.t('shared.navbar.sign_in')

    # It doesn't let me sign in without credentials
    click_on I18n.t('devise.sessions.submit_button')
    expect(page).to have_content(I18n.t('devise.sessions.invalid_email_or_password'))

    # When I fill out credentials
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_on I18n.t('devise.sessions.submit_button')

    # It signs me in
    expect(page).to have_content(
      I18n.t('shared.navbar.signed_in_as', name: [user.first_name, user.last_name].join(' '))
    )
  end

  scenario 'User signs out' do
    # I am signed in
    login_as user, scope: :user

    # I land on the site
    visit root_path

    # When I click logout
    click_on I18n.t('shared.navbar.logout')

    # I am successfully redirected to root
    expect(current_path).to eq(root_path)

    # And I'm not signed in any more
    expect(page).to_not have_content(I18n.t('shared.navbar.logout'))
  end
end
