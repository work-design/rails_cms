if defined?(@video)
  json.video @video, partial: 'detail', as: :video
end
if defined?(@pre_videos)
  json.pre @pre_videos, partial: 'detail', as: :video
end
if defined?(@next_videos)
  json.next @next_videos, partial: 'detail', as: :video
end
