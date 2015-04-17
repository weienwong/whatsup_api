require 'test_helper'

class JobInfoSessionsControllerTest < ActionController::TestCase
  setup do
    @job_info_session = job_info_sessions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:job_info_sessions)
  end

  test "should create job_info_session" do
    assert_difference('JobInfoSession.count') do
      post :create, job_info_session: { description: @job_info_session.description, employer: @job_info_session.employer, end_time: @job_info_session.end_time, start_time: @job_info_session.start_time, target_audience: @job_info_session.target_audience, website: @job_info_session.website }
    end

    assert_response 201
  end

  test "should show job_info_session" do
    get :show, id: @job_info_session
    assert_response :success
  end

  test "should update job_info_session" do
    put :update, id: @job_info_session, job_info_session: { description: @job_info_session.description, employer: @job_info_session.employer, end_time: @job_info_session.end_time, start_time: @job_info_session.start_time, target_audience: @job_info_session.target_audience, website: @job_info_session.website }
    assert_response 204
  end

  test "should destroy job_info_session" do
    assert_difference('JobInfoSession.count', -1) do
      delete :destroy, id: @job_info_session
    end

    assert_response 204
  end
end
