require "test_helper"

class PlayersControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get players_create_url
    assert_response :success
  end

  test "should get destroy" do
    get players_destroy_url
    assert_response :success
  end

  test "should get approve" do
    get players_approve_url
    assert_response :success
  end

  test "should get reject" do
    get players_reject_url
    assert_response :success
  end
end
