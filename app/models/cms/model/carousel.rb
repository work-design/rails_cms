module Cms
  module Model::Carousel
    extend ActiveSupport::Concern

    included do
      attribute :title, :string
      attribute :position, :integer
      attribute :link, :string
      attribute :enabled, :boolean, default: true

      has_one_attached :image

      belongs_to :organ, class_name: 'Org::Organ', optional: true

      positioned on: :organ_id

      scope :enabled, -> { where(enabled: true) }
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
        ((r.max || 1) * 100).to_fs(:percentage, precision: 0)
      end

      def min_ratio
        r = with_attached_image.map(&:ratio)
        ((r.min || 1) * 100).to_fs(:percentage, precision: 0)
      end

    end

  end
end
