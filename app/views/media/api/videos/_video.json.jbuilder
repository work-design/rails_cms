json.extract! video,
              :id,
              :title,
              :cover_url,
              :share_url,
              :view_count,
              :liked_count,
              :share_count,
              :created_at,
              :rewardable
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
