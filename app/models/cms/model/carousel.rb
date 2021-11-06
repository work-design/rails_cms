module Cms
  module Model::Carousel
    extend ActiveSupport::Concern

    included do
      attribute :title, :string
      attribute :position, :integer

      has_one_attached :image

      belongs_to :organ, class_name: 'Org::Organ', optional: true

      acts_as_list scope: :organ_id
    end

  end
end
