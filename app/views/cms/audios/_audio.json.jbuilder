json.extract! audio, :id, :title, :cover_url, :media_url, :duration
if audio.author
  json.author audio.author, :id, :name, :avatar_url
end
