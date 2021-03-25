require 'application_system_test_case'


class SessionsTest < ApplicationSystemTestCase

  def before_setup
    super
    @email = 'ac@mail.ru'
    @password = 'sleJ4Ksn3dm'
    @name = 'name'
    @def_locale="en"
  end

  test 'should not login user with invalid credentials' do
    visit new_user_session_path
    fill_in 'Email', with: 'invalidmail'
    fill_in 'Password', with: @password
    click_button'Log in', name: "commit"
    assert_current_path new_user_session_path
  end

  test 'should create new user, log in witt new credentials and calculate' do
    visit "users/sign_up"

    fill_in 'Email', with: @email
    fill_in 'Password', with: @password
    fill_in  'Password confirmation', with: @password
    fill_in 'Name', with: @name
    sleep 1
    click_on 'Sign up'

    assert User.find_by_email(@email)
    sleep 1


    click_on 'Log out'

    fill_in 'Email', with: @email
    fill_in 'Password', with: @password
    click_button'Log in', name: "commit"

    assert_current_path "/#{@def_locale}"+user_profile_path

    sleep 1

  end


  def teardown

  end


end
