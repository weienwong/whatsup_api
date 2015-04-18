require 'test_helper'

class FacultiesControllerTest < ActionController::TestCase
  setup do
    @faculty = faculties(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:faculties)
  end

  test "should create faculty" do
    assert_difference('Faculty.count') do
      post :create, faculty: { faculty: @faculty.faculty, faculty_short: @faculty.faculty_short }
    end

    assert_response 201
  end

  test "should show faculty" do
    get :show, id: @faculty
    assert_response :success
  end

  test "should update faculty" do
    put :update, id: @faculty, faculty: { faculty: @faculty.faculty, faculty_short: @faculty.faculty_short }
    assert_response 204
  end

  test "should destroy faculty" do
    assert_difference('Faculty.count', -1) do
      delete :destroy, id: @faculty
    end

    assert_response 204
  end
end
