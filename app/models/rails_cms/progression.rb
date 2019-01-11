class Progression < ApplicationRecord
  belongs_to :user
  belongs_to :progressive, polymorphic: true

  enum state: {
    init: 'init',
    doing: 'doing',
    done: 'done'
  }

end
