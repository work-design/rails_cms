# frozen_string_literal: true

module Cms
  module Model::Tag
    extend ActiveSupport::Concern

    included do
      attribute :name, :string

      has_many :audio_tags
      has_many :audios, through: :audio_tags
    end

  end
end
