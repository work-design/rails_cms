module Cms
  class Admin::CarouselsController < Admin::BaseController

    def index
      @carousels = Carousel.order(id: :asc).page(params[:page])
    end

  end
end
