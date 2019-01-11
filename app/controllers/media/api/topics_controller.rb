class Cms::Api::TopicsController < Cms::Api::BaseController
  before_action :set_topic, only: [:show, :update, :destroy]
  before_action :require_login_from_token, only: [:create, :update, :destroy]

  def index
    @topics = Topic.page(params[:page])
    if current_user
      @star_ids = current_user.stars.where(starred_type: 'Topic', starred_id: @topics.pluck(:id)).pluck(:starred_id)
    end
  end

  def show
    if current_user
      @star_ids = current_user.stars.where(starred_type: 'Topic', starred_id: @topic.id).pluck(:starred_id)
    end
  end

  def create
    @topic = Topic.new(topic_params)

    if @topic.save
      render :show, status: :created
    else
      render json: @topic.errors, status: :unprocessable_entity
    end
  end

  def update
    if @topic.update(topic_params)
      render :show
    else
      render json: @topic.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @topic.destroy
  end

  private
  def set_topic
    @topic = Topic.find(params[:id])
  end

  def topic_params
    params.fetch(:topic, {}).permit(
      :title,
      :tag_strings,
      :body,
      images: []
    ).merge(
      author_id: current_user.id
    )
  end
end
