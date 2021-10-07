require 'active_support/configurable'

module RailsCms
  include ActiveSupport::Configurable

  configure do |config|
    config.water_mark = false
    config.water_mark_url = 'http://cloud.1314-edu.com/watermark.gif'
  end

end
