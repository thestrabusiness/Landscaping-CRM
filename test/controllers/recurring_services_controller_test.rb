require 'test_helper'

class RecurringServicesControllerTest < ActionController::TestCase
  setup do
    @recurring_service = recurring_services(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:recurring_services)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create recurring_service" do
    assert_difference('RecurringService.count') do
      post :create, recurring_service: { name: @recurring_service.name }
    end

    assert_redirected_to recurring_service_path(assigns(:recurring_service))
  end

  test "should show recurring_service" do
    get :show, id: @recurring_service
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @recurring_service
    assert_response :success
  end

  test "should update recurring_service" do
    patch :update, id: @recurring_service, recurring_service: { name: @recurring_service.name }
    assert_redirected_to recurring_service_path(assigns(:recurring_service))
  end

  test "should destroy recurring_service" do
    assert_difference('RecurringService.count', -1) do
      delete :destroy, id: @recurring_service
    end

    assert_redirected_to recurring_services_path
  end
end
