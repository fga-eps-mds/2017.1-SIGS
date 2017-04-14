require 'test_helper'

class UserManagerControllerTest < ActionDispatch::IntegrationTest
  test "should get registration_request" do
    get user_manager_registration_request_url
    assert_response :success
  end

  test "should get index" do
    get user_manager_index_url
    assert_response :success
  end

  test "should get edit" do
    get user_manager_edit_url
    assert_response :success
  end

  test "should get update" do
    get user_manager_update_url
    assert_response :success
  end

  test "should get view" do
    get user_manager_view_url
    assert_response :success
  end

  test "should get remove" do
    get user_manager_remove_url
    assert_response :success
  end

  test "should get enable" do
    get user_manager_enable_url
    assert_response :success
  end

end
