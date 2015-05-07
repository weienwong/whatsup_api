require 'test_helper'

class UniversityEventsControllerTest < ActionController::TestCase
  setup do
    @university_event = university_events(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:university_events)
  end

  test "should create university_event" do
    assert_difference('UniversityEvent.count') do
      post :create, university_event: {  }
    end

    assert_response 201
  end

  test "should show university_event" do
    get :show, id: @university_event
    assert_response :success
  end

  test "should update university_event" do
    put :update, id: @university_event, university_event: {  }
    assert_response 204
  end

  test "should destroy university_event" do
    assert_difference('UniversityEvent.count', -1) do
      delete :destroy, id: @university_event
    end

    assert_response 204
  end
end
