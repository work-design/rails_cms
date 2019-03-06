class CountCacheJob < ApplicationJob

  def perform
    Video.find_each do |video|
      video.share_count_cache
    end
  end

end
