module Cms
  class CarouselsController < BaseController

    def index
      @carousels = Carousel.page(params[:page]).per(params[:per])
    end

  end
end
