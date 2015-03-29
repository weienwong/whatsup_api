require 'test_helper'

class EventCategoriesControllerTest < ActionController::TestCase
  setup do
    @event_category = event_categories(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:event_categories)
  end

  test "should create event_category" do
    assert_difference('EventCategory.count') do
      post :create, event_category: { category_name: @event_category.category_name }
    end

    assert_response 201
  end

  test "should show event_category" do
    get :show, id: @event_category
    assert_response :success
  end

  test "should update event_category" do
    put :update, id: @event_category, event_category: { category_name: @event_category.category_name }
    assert_response 204
  end

  test "should destroy event_category" do
    assert_difference('EventCategory.count', -1) do
      delete :destroy, id: @event_category
    end

    assert_response 204
  end
end
