require 'rails_com'
module RailsCms
  class Engine < ::Rails::Engine

    config.autoload_paths += Dir[
      "#{config.root}/app/models/tag",
      "#{config.root}/app/models/taxon"
    ]

    config.generators do |g|
      g.resource_route false
      g.rails = {
        assets: false,
        stylesheets: false,
        helper: false
      }
      g.test_unit = {
        fixture: true
      }
      g.templates.prepend File.expand_path('lib/templates', RailsCom::Engine.root)
    end

    initializer 'rails_cms.add_json_paths' do
      ActiveSupport.on_load(:action_controller_base) do
        append_view_path RailsCms::Engine.root.join('app/jsons')
      end
    end

  end
end
