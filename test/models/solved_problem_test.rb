require 'test_helper'

class SolvedProblemTest < ActiveSupport::TestCase

  def before_setup
    super
    @problem_id = 2 # any integer
    @user_id = 3 # any integer
  end

  test 'should set and get values' do
    instance = SolvedProblem.new
    instance.problem_id = @problem_id
    instance.user_id = @user_id
    assert_equal instance.problem_id, @problem_id
    assert_equal instance.user_id, @user_id
  end

  test 'should save data into db' do
    instance = SolvedProblem.new
    instance.problem_id = @problem_id
    instance.user_id = @user_id
    assert instance.save
  end

end
