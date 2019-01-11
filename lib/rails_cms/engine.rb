module RailsCms
  class Engine < ::Rails::Engine

    config.eager_load_paths += Dir[
      "#{config.root}/app/models/rails_cms",
      "#{config.root}/app/models/rails_cms/posts",
      "#{config.root}/app/models/rails_cms/tags",
      "#{config.root}/app/models/rails_cms/taxons"
    ]

  end
end
