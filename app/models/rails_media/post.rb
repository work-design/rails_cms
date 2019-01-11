class Post < ApplicationRecord
  include CheckMachine
  attribute :state, :string, default: 'init'

  belongs_to :verifier, class_name: 'User', optional: true
  belongs_to :author, class_name: 'User', optional: true
  has_many :comments, as: :commentable
  has_many :stars, as: :starred

  has_rich_text :content
  has_translations :title

  enum state: {
    init: 'init',
    published: 'published',
    rejected: 'rejected'
  }

  acts_as_notify :default, methods: [:state_i18n]

  def do_trigger(params = {})
    self.trigger_to state: params[:state]

    self.class.transaction do
      self.save!
      to_notification(
        receiver: self.verifier,
        link: url_helpers.admin_post_url(id: self.id),
        verbose: true
      ) if self.verifier
    end
  end

  def starred?(user_id)
    self.stars.exists?(user_id: user_id)
  end

  def content_body
    content.to_s
  end

end
