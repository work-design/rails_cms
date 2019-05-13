class Video < ApplicationRecord
  include RailsMedia::Video
  include CheckMachine
  include RailsGrowthEntity
  include RailsInteract::Like
  include RailsInteract::Commentable
end unless defined? Video
