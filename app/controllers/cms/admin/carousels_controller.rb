module Cms
  class Admin::CarouselsController < Admin::BaseController

    def index
      q_params = {}
      q_params.merge! default_params

      @carousels = Carousel.default_where(q_params).order(id: :asc).page(params[:page])
    end

  end
end
