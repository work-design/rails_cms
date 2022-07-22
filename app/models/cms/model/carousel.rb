module Cms
  module Model::Carousel
    extend ActiveSupport::Concern

    included do
      attribute :title, :string
      attribute :position, :integer
      attribute :link_controller, :string
      attribute :link_action, :string
      attribute :link_params, :json

      has_one_attached :image

      belongs_to :organ, class_name: 'Org::Organ', optional: true

      acts_as_list scope: :organ_id

      default_scope -> { order(position: :asc) }
    end

    def ratio
      width = image.blob.metadata['width']
      height = image.blob.metadata['height']
      if width && height
        (height.to_d / width).round(2)
      else
        0
      end
    end

    class_methods do

      def max_ratio
        r = with_attached_image.map(&:ratio)
        r.max || 1
      end

    end

  end
end
