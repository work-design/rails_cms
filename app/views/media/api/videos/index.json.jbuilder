json.partial! 'api/shared/pagination', items: @videos

json.videos do
  json.array! @videos do |video|
    json.id video.id
    json.title video.title
    json.cover_url video.cover_url
    json.view_count video.view_count
    json.liked_count video.liked_count
    json.share_count video.share_count
    json.created_at video.created_at
    json.rewardable video.rewardable
    json.share_url video.share_url(current_user)
    json.comments_count video.comments.count
    if video.author
      json.author video.author, :id, :name, :avatar_url
    end
    json.media do
      json.extract! video.media.metadata, *(video.media.metadata.keys & ['height', 'width'])
      json.duration video.media.blob.duration
      json.duration_str video.media.blob.duration_str
      json.url video.media.service_url
      json.wm_url video.media_wm_url
    end
    if video.video_taxon
      json.video_taxon video.video_taxon, :id, :name
    end
    if current_user
      json.starred @star_ids.include?(video.id)
      json.viewed video.viewed?(current_user.id)
      json.liked video.liked?(current_user.id)
      json.rewardable_codes video.rewardable_codes(current_user.id)
    end
  end
end

