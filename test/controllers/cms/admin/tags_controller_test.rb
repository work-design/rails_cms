require 'test_helper'
class Cms::Admin::TagsControllerTest < ActionDispatch::IntegrationTest

  setup do
    @tag = tags(:one)
  end

  test 'index ok' do
    get url_for(controller: 'cms/admin/tags')

    assert_response :success
  end

  test 'new ok' do
    get url_for(controller: 'cms/admin/tags')

    assert_response :success
  end

  test 'create ok' do
    assert_difference('Tag.count') do
      post(
        url_for(controller: 'cms/admin/tags', action: 'create'),
        params: { tag: { name: @cms_admin_tag.name } },
        as: :turbo_stream
      )
    end

    assert_response :success
  end

  test 'show ok' do
    get url_for(controller: 'cms/admin/tags', action: 'show', id: @tag.id)

    assert_response :success
  end

  test 'edit ok' do
    get url_for(controller: 'cms/admin/tags', action: 'edit', id: @tag.id)

    assert_response :success
  end

  test 'update ok' do
    patch(
      url_for(controller: 'cms/admin/tags', action: 'update', id: @tag.id),
      params: { tag: { name: @cms_admin_tag.name } },
      as: :turbo_stream
    )

    assert_response :success
  end

  test 'destroy ok' do
    assert_difference('Tag.count', -1) do
      delete url_for(controller: 'cms/admin/tags', action: 'destroy', id: @tag.id), as: :turbo_stream
    end

    assert_response :success
  end

end
