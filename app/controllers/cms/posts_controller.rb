class Cms::PostsController < Cms::BaseController
  before_action :set_post, only: [:show]

  def index
    q_params = {}.with_indifferent_access
    q_params.merge! params.fetch(:q, {}).permit!
    @posts = Post.default_where(q_params).page(params[:page])
  end

  def show
  end

  def code
    @white_header = 'white-header'
    @post = InnerPost.find_by(code: params[:code])
    render :show
  end

  private
  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.fetch(:post, {}).permit(
      :name,
      :code,
      :content
    )
  end

end
