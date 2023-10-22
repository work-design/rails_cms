require "application_system_test_case"

class TagsTest < ApplicationSystemTestCase
  setup do
    @cms_admin_tag = cms_admin_tags(:one)
  end

  test "visiting the index" do
    visit cms_admin_tags_url
    assert_selector "h1", text: "Tags"
  end

  test "should create tag" do
    visit cms_admin_tags_url
    click_on "New tag"

    fill_in "Name", with: @cms_admin_tag.name
    click_on "Create Tag"

    assert_text "Tag was successfully created"
    click_on "Back"
  end

  test "should update Tag" do
    visit cms_admin_tag_url(@cms_admin_tag)
    click_on "Edit this tag", match: :first

    fill_in "Name", with: @cms_admin_tag.name
    click_on "Update Tag"

    assert_text "Tag was successfully updated"
    click_on "Back"
  end

  test "should destroy Tag" do
    visit cms_admin_tag_url(@cms_admin_tag)
    click_on "Destroy this tag", match: :first

    assert_text "Tag was successfully destroyed"
  end
end
