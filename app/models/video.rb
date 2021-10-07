module Cms
  class Video < ApplicationRecord
    include Model::Video
    #include CheckMachine
    include Growth::Ext::Entity
    include Interact::Model::Like
    include Interact::Model::Commentable
  end
end
