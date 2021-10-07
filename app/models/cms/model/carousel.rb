module Cms
  module Model::Carousel
    extend ActiveSupport::Concern

    included do
      attribute :title, :string

      has_one_attached :image
    end

  end
end
