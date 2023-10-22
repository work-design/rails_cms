# frozen_string_literal: true

module Cms
  module Model::AudioTag
    extend ActiveSupport::Concern

    included do
      belongs_to :audio
      belongs_to :tag
    end

  end
end
