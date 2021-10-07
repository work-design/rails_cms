module RailsCms
  class Engine < ::Rails::Engine

    config.autoload_paths += Dir[
      "#{config.root}/app/models/tag",
      "#{config.root}/app/models/taxon"
    ]

  end
end
