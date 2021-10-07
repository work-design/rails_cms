module Cms
  class VideoWmJob < ApplicationJob

    def perform(video)
      video.water_mark
    end

  end
end
