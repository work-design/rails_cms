json.partial! 'video', video: video
json.tags video.tags do |tag|
  json.extract! tag, :id, :name
end
json.comments video.comments do |comment|
  json.extract! comment, :id, :title, :content, :state, :score, :liked_count
  json.commenter comment.commenter, :id, :name, :avatar_url
end