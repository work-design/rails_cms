json.partial! 'video', video: video
json.tags video.tags do |tag|
  json.extract! tag, :id, :name
end
json.comments video.comments do |comment|
  json.extract! comment, :id, :title, :content, :state, :score, :liked_count, :created_at
  json.commenter comment.user, :id, :name, :avatar_url
end
