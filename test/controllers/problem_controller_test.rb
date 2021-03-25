require 'test_helper'

class ProblemControllerTest < ActionDispatch::IntegrationTest

  test "should get all" do
    get problem_all_path
    assert_response :success
  end

  test "should redirect to log in page" do
    get problem_edit_path
    assert_redirected_to new_user_session_path
  end

end
