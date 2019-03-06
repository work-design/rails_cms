class CountCacheJob < ApplicationJob

  def perform(video)
    video.share_count_cache
  end

end
