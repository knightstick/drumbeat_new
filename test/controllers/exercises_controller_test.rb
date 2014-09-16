require 'test_helper'

class ExercisesControllerTest < ActionController::TestCase
  setup :login_as_chris
  
  
  test "should get index" do
    get :index
    assert_response :success
  end
  
  test "should get show" do
    roll = exercises(:roll)
    get :show, id: roll.id
    assert_response :success
  end

end
