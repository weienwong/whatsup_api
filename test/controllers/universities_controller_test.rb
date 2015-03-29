require 'test_helper'

class UniversitiesControllerTest < ActionController::TestCase
  setup do
    @university = universities(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:universities)
  end

  test "should create university" do
    assert_difference('University.count') do
      post :create, university: { name: @university.name }
    end

    assert_response 201
  end

  test "should show university" do
    get :show, id: @university
    assert_response :success
  end

  test "should update university" do
    put :update, id: @university, university: { name: @university.name }
    assert_response 204
  end

  test "should destroy university" do
    assert_difference('University.count', -1) do
      delete :destroy, id: @university
    end

    assert_response 204
  end
end
