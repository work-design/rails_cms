class Cms::Api::VideosController < Cms::Api::BaseController
  before_action :set_video, only: [:show, :viewed, :update, :destroy]

  def index
    q_params = params.permit(:video_taxon_id)
    @videos = Video.default_where(q_params).order(id: :desc).page(params[:page]).per(params[:per])

    if current_user
      @star_ids = current_user.stars.where(starred_type: 'Video', starred_id: @videos.pluck(:id)).pluck(:starred_id)
    end
  end

  def show
    if current_user
      @star_ids = current_user.stars.where(starred_type: 'Video', starred_id: @video.id).pluck(:starred_id)
    end
  end

  def viewed
    p = @video.progressions.find_or_initialize_by(user_id: current_user.id)
    p.state = 'done'
    p.save

    if current_user
      @star_ids = current_user.stars.where(starred_type: 'Video', starred_id: @video.id).pluck(:starred_id)
    end

    render 'show'
  end

  def create
    @video = Video.new(video_params)

    if @video.save
      if current_user
        @star_ids = current_user.stars.where(starred_type: 'Video', starred_id: @video.id).pluck(:starred_id)
      end
      render 'show', status: :created
    else
      render json: @video.errors, status: :unprocessable_entity
    end
  end

  def update
    if current_user
      @star_ids = current_user.stars.where(starred_type: 'Video', starred_id: @video.id).pluck(:starred_id)
    end
    if @video.update(video_params)
      render 'show'
    else
      render json: @video.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @video.destroy
  end

  private
  def set_video
    @video = Video.find(params[:id])
  end

  def video_params
    params.fetch(:video, {}).permit(
      :title,
      :media,
      :cover,
      :video_taxon_id,
      tag_ids: []
    ).merge(author_id: current_user.id)
  end
end
