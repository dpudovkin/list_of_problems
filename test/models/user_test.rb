require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def before_setup
    super
    @email = 'abf@mail.ru'
    @password = 'sleJ4Ksn3dm'
    @name = 'name'
  end

  test 'should set and get values' do
    instance = User.new
    instance.email = @email
    assert_equal instance.email, @email
  end

  test 'should save data into db' do
    instance = User.new
    instance.email = @email
    instance.password = @password
    instance.name = @name
    assert instance.save
    instance.delete
  end
end
