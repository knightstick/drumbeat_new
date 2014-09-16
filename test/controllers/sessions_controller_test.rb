require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  test "should get login" do
    get :new
    assert_response :success
    assert_select "title", "Drumbeat | Log In"
  end

  test "should get create" do
    get :create
    assert_response :success
  end

  test "should get destroy" do
    login_as_chris
    
    get :destroy
    assert_redirected_to root_path
  end

end
