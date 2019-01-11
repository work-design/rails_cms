module RailsMedia
  class Engine < ::Rails::Engine

    config.eager_load_paths += Dir[
      "#{config.root}/app/models/rails_media",
      "#{config.root}/app/models/rails_media/posts",
      "#{config.root}/app/models/rails_media/tags",
      "#{config.root}/app/models/rails_media/taxons"
    ]

  end
end
