json.videos @videos, partial: 'video', as: :video
json.partial! 'api/shared/pagination', items: @videos
