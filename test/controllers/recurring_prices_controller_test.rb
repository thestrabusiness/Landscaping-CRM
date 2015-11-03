require 'test_helper'

class RecurringPricesControllerTest < ActionController::TestCase
  setup do
    @recurring_price = recurring_prices(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:recurring_prices)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create recurring_price" do
    assert_difference('RecurringPrice.count') do
      post :create, recurring_price: { clients_id: @recurring_price.clients_id, price: @recurring_price.price, recurring_services_id: @recurring_price.recurring_services_id }
    end

    assert_redirected_to recurring_price_path(assigns(:recurring_price))
  end

  test "should show recurring_price" do
    get :show, id: @recurring_price
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @recurring_price
    assert_response :success
  end

  test "should update recurring_price" do
    patch :update, id: @recurring_price, recurring_price: { clients_id: @recurring_price.clients_id, price: @recurring_price.price, recurring_services_id: @recurring_price.recurring_services_id }
    assert_redirected_to recurring_price_path(assigns(:recurring_price))
  end

  test "should destroy recurring_price" do
    assert_difference('RecurringPrice.count', -1) do
      delete :destroy, id: @recurring_price
    end

    assert_redirected_to recurring_prices_path
  end
end
