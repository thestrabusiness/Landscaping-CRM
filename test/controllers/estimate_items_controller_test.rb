require 'test_helper'

class EstimateItemsControllerTest < ActionController::TestCase
  setup do
    @estimate_item = estimate_items(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:estimate_items)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create estimate_item" do
    assert_difference('EstimateItem.count') do
      post :create, estimate_item: { estimate_id: @estimate_item.estimate_id, name: @estimate_item.name, price: @estimate_item.price, quantity: @estimate_item.quantity }
    end

    assert_redirected_to estimate_item_path(assigns(:estimate_item))
  end

  test "should show estimate_item" do
    get :show, id: @estimate_item
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @estimate_item
    assert_response :success
  end

  test "should update estimate_item" do
    patch :update, id: @estimate_item, estimate_item: { estimate_id: @estimate_item.estimate_id, name: @estimate_item.name, price: @estimate_item.price, quantity: @estimate_item.quantity }
    assert_redirected_to estimate_item_path(assigns(:estimate_item))
  end

  test "should destroy estimate_item" do
    assert_difference('EstimateItem.count', -1) do
      delete :destroy, id: @estimate_item
    end

    assert_redirected_to estimate_items_path
  end
end
