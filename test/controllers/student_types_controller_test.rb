require 'test_helper'

class StudentTypesControllerTest < ActionController::TestCase
  setup do
    @student_type = student_types(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:student_types)
  end

  test "should create student_type" do
    assert_difference('StudentType.count') do
      post :create, student_type: { student_type: @student_type.student_type }
    end

    assert_response 201
  end

  test "should show student_type" do
    get :show, id: @student_type
    assert_response :success
  end

  test "should update student_type" do
    put :update, id: @student_type, student_type: { student_type: @student_type.student_type }
    assert_response 204
  end

  test "should destroy student_type" do
    assert_difference('StudentType.count', -1) do
      delete :destroy, id: @student_type
    end

    assert_response 204
  end
end
