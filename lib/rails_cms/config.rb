require 'active_support/configurable'

module RailsCms
  include ActiveSupport::Configurable

  configure do |config|
    config.water_mark = false
  end

end
