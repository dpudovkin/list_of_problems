require 'test_helper'

class UserControllerTest < ActionDispatch::IntegrationTest


  test "should get login page" do
    get new_user_session_path
    assert_response :success
  end

  test 'should redirect to profile page' do
    get user_profile_path
    assert_redirected_to new_user_session_path
  end

  test "should get rating" do
    get user_rating_path
    assert_response :success
  end

end
