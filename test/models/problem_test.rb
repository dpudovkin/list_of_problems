require 'test_helper'

class ProblemTest < ActiveSupport::TestCase
  def before_setup
    super
    @title = 'random title'
    @text = 'random text condition'
    @answer = 5
    @author = 5
  end

  test 'should set and get values' do
    instance = Problem.new
    instance.title = @title
    assert_equal instance.title, @title
  end

  test 'should save data into db' do
    instance = Problem.new
    instance.title = @title
    instance.text = @text
    instance.answer = @answer
    instance.author = @author
    assert instance.save
    instance.delete
  end

  test 'should save problem and check count of problem by user' do
    instance = Problem.new
    instance.title = @title
    instance.text = @text
    instance.answer = @answer
    instance.author = @author
    instance.save
    assert_equal Problem.by_user(@author).length, 1
  end
end
