require 'test_helper'

class GameControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get game_new_url
    assert_response :success
  end

  test "should get show" do
    get game_show_url
    assert_response :success
  end

end
