class Media::Api::VideosController < Media::Api::BaseController
  before_action :set_video, only: [:show, :viewed, :update, :destroy]
  before_action :require_login, only: [:viewed, :starred, :create, :update, :destroy]

  def index
    q_params = params.permit(:video_taxon_id, :author_id, 'title-like')
    unless q_params[:author_id]
      q_params.merge! state: 'verified'
    end

    @videos = Video.default_where(q_params).order(id: :desc).page(params[:page]).per(params[:per])

    if current_user
      @star_ids = current_user.stars.where(starred_type: 'Video', starred_id: @videos.pluck(:id)).pluck(:starred_id)
    end
  end

  def list
    ids = []
    if params[:id]
      set_video
      ids << params[:id]
    end

    q_params = params.permit(:video_taxon_id, :author_id, 'title-like', :per)
    unless q_params[:author_id]
      q_params.merge! state: 'verified'
    end

    if @video
      if params[:scope].blank? || params[:scope] == 'pre'
        @pre_videos = @video.pre_videos(q_params)
        ids += @pre_videos.pluck(:id)
      end
      if params[:scope].blank? || params[:scope] == 'next'
        @next_videos = @video.next_videos(q_params)
        ids += @next_videos.pluck(:id)
      end
    else
      @next_videos = Video.default_where(q_params).order(id: :desc).page(params[:page]).per(params[:per])
      ids += @next_videos.pluck(:id)
    end
    if current_user && params[:starred]
      @star_ids = current_user.stars.where(starred_type: 'Video').pluck(:starred_id)
      @next_videos = @next_videos.where(id: @star_ids)
      @pre_videos = @pre_videos.where(id: @star_ids) if @pre_videos
    elsif current_user
      @star_ids = current_user.stars.where(starred_type: 'Video', starred_id: ids).pluck(:starred_id)
    end
  end

  def starred
    @star_ids = current_user.stars.where(starred_type: 'Video').pluck(:starred_id)
    @videos = Video.where(id: @star_ids).page(params[:page])
    render :index
  end

  def show
  end

  def videos
    @videos = user.videos
    render json: { videos: @videos }
  end

  def viewed
    p = @video.progressions.find_or_initialize_by(user_id: current_user.id)
    p.state = 'done'
    p.save

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
    if current_user
      @star_ids = current_user.stars.where(starred_type: 'Video', starred_id: @video.id).pluck(:starred_id)
    end
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
