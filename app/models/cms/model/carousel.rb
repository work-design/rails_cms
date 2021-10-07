module Cms
  module Model::Carousel
    extend ActiveSupport::Concern

    included do
      attribute :title, :string

      has_one_attached :image

      belongs_to :organ, class_name: 'Org::Organ', optional: true
    end

  end
end
