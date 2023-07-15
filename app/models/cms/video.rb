module Cms
  class Video < ApplicationRecord
    include Model::Video
    #include CheckMachine
    include Growth::Ext::Entity if defined? RailsGrowth
    if defined? RailsInteract
      include Interact::Ext::Like
      include Interact::Ext::Commentable
    end
  end
end
