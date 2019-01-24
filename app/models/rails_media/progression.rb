class Progression < ApplicationRecord
  belongs_to :user
  belongs_to :progressive, polymorphic: true, counter_cache: :view_count

  enum state: {
    init: 'init',
    doing: 'doing',
    done: 'done'
  }

end
