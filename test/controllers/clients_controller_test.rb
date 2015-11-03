require 'test_helper'

class ClientsControllerTest < ActionController::TestCase
  setup do
    @client = clients(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:clients)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create client" do
    assert_difference('Client.count') do
      post :create, client: { balance: @client.balance, billing_address: @client.billing_address, bush: @client.bush, city: @client.city, cut: @client.cut, fall: @client.fall, first_name: @client.first_name, job_address: @client.job_address, last_name: @client.last_name, mulch: @client.mulch, snow: @client.snow, spring: @client.spring, state: @client.state, zip: @client.zip }
    end

    assert_redirected_to client_path(assigns(:client))
  end

  test "should show client" do
    get :show, id: @client
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @client
    assert_response :success
  end

  test "should update client" do
    patch :update, id: @client, client: { balance: @client.balance, billing_address: @client.billing_address, bush: @client.bush, city: @client.city, cut: @client.cut, fall: @client.fall, first_name: @client.first_name, job_address: @client.job_address, last_name: @client.last_name, mulch: @client.mulch, snow: @client.snow, spring: @client.spring, state: @client.state, zip: @client.zip }
    assert_redirected_to client_path(assigns(:client))
  end

  test "should destroy client" do
    assert_difference('Client.count', -1) do
      delete :destroy, id: @client
    end

    assert_redirected_to clients_path
  end
end
