require 'active_support/configurable'

module RailsMedia
  include ActiveSupport::Configurable

  configure do |config|
    config.admin_class = 'AdminController'
    config.my_class = 'MyController'
    config.api_class = 'ApiController'
    config.disabled_models = []
    config.water_mark_url = 'http://cloud.1314-edu.com/watermark.gif'
  end

end
