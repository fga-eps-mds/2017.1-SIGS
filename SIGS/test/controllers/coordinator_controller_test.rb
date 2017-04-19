require 'test_helper'

class CoordinatorControllerTest < ActionDispatch::IntegrationTest
  test "should get registration_request" do
    get coordinator_registration_request_url
    assert_response :success
  end

  test "should get edit" do
    get coordinator_edit_url
    assert_response :success
  end

  test "should get update" do
    get coordinator_update_url
    assert_response :success
  end

  test "should get show" do
    get coordinator_show_url
    assert_response :success
  end

  test "should get destroy" do
    get coordinator_destroy_url
    assert_response :success
  end

  test "should get enable" do
    get coordinator_enable_url
    assert_response :success
  end

end
