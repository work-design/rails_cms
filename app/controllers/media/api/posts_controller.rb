class Cms::Api::PostsController < Cms::Api::BaseController
  before_action :set_post, only: [:show, :update, :star, :cancel_star, :destroy]

  def index
    q_params = {}.with_indifferent_access
    q_params.merge! params.permit(:'created_at-desc')
    @posts = Post.default_where(q_params).page(params[:page]).per(params[:per])

    if current_user
      @star_ids = current_user.stars.where(starred_type: 'Post', starred_id: @posts.pluck(:id)).pluck(:starred_id)
    end

    render 'index'
  end

  def show
    post = @post.as_json(methods: [:content_body])
    if current_user
      @star_ids = current_user.stars.where(starred_type: 'Post', starred_id: @post.id).pluck(:starred_id)
    end
    render 'show'
  end

  def create
    @post = Post.new(post_params)
    @star_ids = []

    if @post.save
      render 'show', status: :created
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  def update
    if current_user
      @star_ids = current_user.stars.where(starred_type: 'Post', starred_id: @post.id).pluck(:starred_id)
    end
    if @post.update(post_params)
      render 'show'
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  def star
    @star = @post.stars.find_or_initialize_by(user_id: current_user.id)

    if @star.save
      render json: @star.as_json(root: true), status: :created
    else
      process_errors(@star)
    end
  end

  def cancel_star
    @star = @post.stars.find_by(user_id: current_user.id)

    if @star && @star.destroy
      render json: @star.as_json(root: true), status: :accepted
    else
      render json: {  }, status: :bad_request
    end
  end

  def destroy
    @post.destroy
  end

  private
  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.fetch(:post, {}).permit(
      :title,
      :code,
      :content,
      tag_ids: []
    ).merge(
      type: 'UGCPost',
      author_id: current_user.id
    )
  end
end
