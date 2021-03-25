require 'application_system_test_case'


class ProblemTest < ApplicationSystemTestCase

  def before_setup
    super
    @email = 'acc@mail.ru'
    @password = '123456'
    @name = 'dima'

    @user = User.create
    @user.name = @name
    @user.password = @password
    @user.email = @email
    @user.save

    @def_locale="en"
    @title = 'testtitle'
    @text ='testtesttesttest'
    @answer = 5
  end

  test 'should create problem and delete' do

    visit new_user_session_path
    fill_in 'Email', with: @email
    fill_in 'Password', with: @password
    click_button 'Log in', name: "commit"
    click_button 'My profile'
    click_link 'Add problem'

    fill_in 'title', with: @title
    fill_in 'text', with: @text
    fill_in 'answer', with: @answer

    click_button 'Post'

    assert Problem.find_by(title: @title)

    click_button 'Delete'
    page.driver.browser.switch_to.alert.accept
    sleep 3

    refute Problem.find_by(title: @title)

  end


  test 'should give answer and earn one star' do
    visit new_user_session_path
    fill_in 'Email', with: @email
    fill_in 'Password', with: @password
    click_button 'Log in', name: "commit"
    visit problem_all_path
    fill_in 'answer', with: 1
    click_button 'Answer'
    sleep 1
    assert User.score(@user.id)==1
    sleep 10
  end

  def teardown
    @user.delete
  end


end
