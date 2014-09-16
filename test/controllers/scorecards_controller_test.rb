require 'test_helper'

class ScorecardsControllerTest < ActionController::TestCase
  setup :login_as_chris
  
  
  test "should get index" do
    get :index
    assert_response :success
  end
end
