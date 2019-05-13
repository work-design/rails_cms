class Video < ApplicationRecord
  include RailsMedia::Video
end unless defined? Video
