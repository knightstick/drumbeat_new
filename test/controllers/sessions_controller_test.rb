require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  test "should get signup" do
    get :new
    assert_response :success
    assert_select "title", "Drumbeat | Sign Up"
  end

  # test "should get create" do
  #   get :create
  #   assert_response :success
  # end

  # test "should get destroy" do
  #   get :destroy
  #   assert_response :success
  # end

end
