class Video < ApplicationRecord
  include RailsMedia::Video
  include CheckMachine
  include RailsGrowth::Entity
  include RailsInteract::Like
  include RailsInteract::Commentable
end unless defined? Video
