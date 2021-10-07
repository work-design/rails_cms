require "application_system_test_case"

class CarouselsTest < ApplicationSystemTestCase
  setup do
    @cms_carousel = cms_carousels(:one)
  end

  test "visiting the index" do
    visit cms_carousels_url
    assert_selector "h1", text: "Carousels"
  end

  test "creating a Carousel" do
    visit cms_carousels_url
    click_on "New Carousel"

    fill_in "Image", with: @cms_carousel.image
    fill_in "Title", with: @cms_carousel.title
    click_on "Create Carousel"

    assert_text "Carousel was successfully created"
    click_on "Back"
  end

  test "updating a Carousel" do
    visit cms_carousels_url
    click_on "Edit", match: :first

    fill_in "Image", with: @cms_carousel.image
    fill_in "Title", with: @cms_carousel.title
    click_on "Update Carousel"

    assert_text "Carousel was successfully updated"
    click_on "Back"
  end

  test "destroying a Carousel" do
    visit cms_carousels_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Carousel was successfully destroyed"
  end
end
