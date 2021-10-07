require 'test_helper'
class Cms::CarouselsControllerTest < ActionDispatch::IntegrationTest

  setup do
    @carousel = carousels(:one)
  end

  test 'index ok' do
    get url_for(controller: 'cms/carousels')

    assert_response :success
  end

  test 'new ok' do
    get url_for(controller: 'cms/carousels')

    assert_response :success
  end

  test 'create ok' do
    assert_difference('Carousel.count') do
      post(
        url_for(controller: 'cms/carousels', action: 'create'),
        params: { carousel: { image: @cms_carousel.image, title: @cms_carousel.title } },
        as: :turbo_stream
      )
    end

    assert_response :success
  end

  test 'show ok' do
    get url_for(controller: 'cms/carousels', action: 'show', id: @carousel.id)

    assert_response :success
  end

  test 'edit ok' do
    get url_for(controller: 'cms/carousels', action: 'edit', id: @carousel.id)

    assert_response :success
  end

  test 'update ok' do
    patch(
      url_for(controller: 'cms/carousels', action: 'update', id: @carousel.id),
      params: { carousel: { image: @cms_carousel.image, title: @cms_carousel.title } },
      as: :turbo_stream
    )

    assert_response :success
  end

  test 'destroy ok' do
    assert_difference('Carousel.count', -1) do
      delete url_for(controller: 'cms/carousels', action: 'destroy', id: @carousel.id), as: :turbo_stream
    end

    assert_response :success
  end

end
