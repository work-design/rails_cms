module Cms
  class Admin::TagsController < Admin::BaseController
    def index
      q_params = {}
      q_params.merge! default_params

      @tags = Tag.default_where(q_params).order(id: :asc).page(params[:page])
    end


  end
end

