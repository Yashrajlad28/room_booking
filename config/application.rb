require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module RoomBooking
  class Application < Rails::Application

    config.load_defaults 8.1

    config.autoload_lib(ignore: %w[assets tasks])


    config.middleware.use ActionDispatch::Cookies
    config.middleware.use ActionDispatch::Session::CookieStore, key: '_room_booking_session'

    config.api_only = false

    config.time_zone = 'Asia/Kolkata' # This is the correct Time Zone for IST
  end
end
