require File.expand_path('../boot', __FILE__)

require 'rails/all'

Bundler.require(:default, Rails.env)

module YoTeach
  class Application < Rails::Application
    config.time_zone = 'UTC'

    config.generators do |g|
      g.test_framework :rspec,
        fixtures: true,
        view_specs: false,
        helper_specs: false,
        routing_specs: false,
        request_specs: true
      g.fixture_replacement :factory_girl,
        dir: "spec/factories"
    end

    config.assets.precompile += %w(*.png *.jpg *.jpeg *.gif)
    config.secret_key_base = Rails.application.secrets.
      secret_key_base

    config.beginning_of_week = :sunday
  end
end
