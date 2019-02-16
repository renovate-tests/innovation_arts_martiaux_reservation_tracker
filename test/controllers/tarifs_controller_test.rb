require 'test_helper'

class TarifsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @tarif = tarifs(:one)
  end

  test "should get index" do
    get tarifs_url
    assert_response :success
  end

  test "should get new" do
    get new_tarif_url
    assert_response :success
  end

  test "should create tarif" do
    assert_difference('Tarif.count') do
      post tarifs_url, params: { tarif: { class_per_week: @tarif.class_per_week, price: @tarif.price } }
    end

    assert_redirected_to tarif_url(Tarif.last)
  end

  test "should show tarif" do
    get tarif_url(@tarif)
    assert_response :success
  end

  test "should get edit" do
    get edit_tarif_url(@tarif)
    assert_response :success
  end

  test "should update tarif" do
    patch tarif_url(@tarif), params: { tarif: { class_per_week: @tarif.class_per_week, price: @tarif.price } }
    assert_redirected_to tarif_url(@tarif)
  end

  test "should destroy tarif" do
    assert_difference('Tarif.count', -1) do
      delete tarif_url(@tarif)
    end

    assert_redirected_to tarifs_url
  end
end
