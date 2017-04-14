require 'test_helper'

class AdministrativeAssistantControllerTest < ActionDispatch::IntegrationTest
  test "should get registration_request" do
    get administrative_assistant_registration_request_url
    assert_response :success
  end

  test "should get edit" do
    get administrative_assistant_edit_url
    assert_response :success
  end

  test "should get update" do
    get administrative_assistant_update_url
    assert_response :success
  end

  test "should get show" do
    get administrative_assistant_show_url
    assert_response :success
  end

  test "should get remove" do
    get administrative_assistant_remove_url
    assert_response :success
  end

  test "should get enable" do
    get administrative_assistant_enable_url
    assert_response :success
  end

  test "should get approve_registration" do
    get administrative_assistant_approve_registration_url
    assert_response :success
  end

  test "should get approve_allocation" do
    get administrative_assistant_approve_allocation_url
    assert_response :success
  end

  test "should get index_users" do
    get administrative_assistant_index_users_url
    assert_response :success
  end

  test "should get view_users" do
    get administrative_assistant_view_users_url
    assert_response :success
  end

  test "should get edit_users" do
    get administrative_assistant_edit_users_url
    assert_response :success
  end

  test "should get remove_users" do
    get administrative_assistant_remove_users_url
    assert_response :success
  end

end
