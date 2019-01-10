class Cms::Api::VideoTagsController < Cms::Api::BaseController
  before_action :set_video_tag, only: [:show, :update, :destroy]

  def index
    @video_tags = VideoTag.page(params[:page]).per(params[:per])

    render json: { video_tags: @video_tags.as_json(only: [:id, :name]) }
  end

  def show
    render json: @video_tag
  end

  def create
    @video_tag = VideoTag.new(video_tag_params)

    if @video_tag.save
      render json: @video_tag, status: :created
    else
      render json: @video_tag.errors, status: :unprocessable_entity
    end
  end

  def update
    if @video_tag.update(video_tag_params)
      render json: @video_tag
    else
      render json: @video_tag.errors, status: :unprocessable_entity
    end
  end

  private
  def set_video_tag
    @video_tag = VideoTag.find(params[:id])
  end

  def video_tag_params
    params.fetch(:video_tag, {}).permit(:name)
  end
end
