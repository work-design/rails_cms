json.video @video, partial: 'detail', as: :video
json.pre_videos @video.pre_videos, partial: 'detail', as: :video
json.next_videos @video.next_videos, partial: 'detail', as: :video
