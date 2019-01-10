json.extract! topic, :id, :title, :created_at, :tag_strings, :body, :stars_count, :liked_count, :disliked_count
if topic.author
  json.author topic.author, :id, :name, :avatar_url
end
if current_user
  json.starred @star_ids.include?(topic.id)
end
json.comments topic.comments do |comment|
  json.extract! comment, :id, :title, :content, :state, :score
  json.commenter comment.commenter, :id, :name, :avatar_url
end
