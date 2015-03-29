require 'test_helper'

class EventHostsControllerTest < ActionController::TestCase
  setup do
    @event_host = event_hosts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:event_hosts)
  end

  test "should create event_host" do
    assert_difference('EventHost.count') do
      post :create, event_host: { description: @event_host.description, host_name: @event_host.host_name, website: @event_host.website }
    end

    assert_response 201
  end

  test "should show event_host" do
    get :show, id: @event_host
    assert_response :success
  end

  test "should update event_host" do
    put :update, id: @event_host, event_host: { description: @event_host.description, host_name: @event_host.host_name, website: @event_host.website }
    assert_response 204
  end

  test "should destroy event_host" do
    assert_difference('EventHost.count', -1) do
      delete :destroy, id: @event_host
    end

    assert_response 204
  end
end
