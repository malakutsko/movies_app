# frozen_string_literal: true

# All translations from config/locales/*.rb,yml are auto loaded.
Rails.application.config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}')]
Rails.application.config.i18n.available_locales = :en
