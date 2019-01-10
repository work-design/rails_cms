json.extract! post, :id, :title, :created_at, :tag_strings, :source, :content_body
if post.author
  json.author post.author, :id, :name, :avatar_url
end
if current_user
  json.starred @star_ids.include?(post.id)
end
