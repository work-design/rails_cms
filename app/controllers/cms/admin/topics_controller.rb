class Cms::Admin::TopicsController < Cms::Admin::BaseController
  before_action :set_topic, only: [:show, :edit, :update, :destroy]

  def index
    @topics = Topic.page(params[:page])
  end

  def new
    @topic = Topic.new
  end

  def create
    @topic = Topic.new(topic_params)

    if @topic.save
      redirect_to admin_topics_url, notice: 'Topic was successfully created.'
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @topic.update(topic_params)
      redirect_to admin_topics_url, notice: 'Topic was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @topic.destroy
    redirect_to admin_topics_url, notice: 'Topic was successfully destroyed.'
  end

  private
  def set_topic
    @topic = Topic.find(params[:id])
  end

  def topic_params
    params.fetch(:topic, {}).permit(
      :title,
      :tag_strings,
      :body
    ).merge(
      author_id: current_user.id
    )
  end

end
