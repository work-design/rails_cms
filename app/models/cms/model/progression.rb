module Cms
  module Model::Progression
    extend ActiveSupport::Concern

    included do
      attribute :rate, :decimal
      attribute :time, :decimal
      attribute :duration, :decimal

      belongs_to :user, class_name: 'Auth::User'
      belongs_to :progressive, polymorphic: true, counter_cache: :view_count

      enum state: {
        init: 'init',
        doing: 'doing',
        done: 'done'
      }
    end

  end
end
