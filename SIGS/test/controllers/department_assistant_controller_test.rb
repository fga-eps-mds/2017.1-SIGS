require 'test_helper'

class DepartmentAssistantControllerTest < ActionDispatch::IntegrationTest
  test "should get registration_request" do
    get department_assistant_registration_request_url
    assert_response :success
  end

  test "should get index" do
    get department_assistant_index_url
    assert_response :success
  end

  test "should get edit" do
    get department_assistant_edit_url
    assert_response :success
  end

  test "should get update" do
    get department_assistant_update_url
    assert_response :success
  end

  test "should get show" do
    get department_assistant_show_url
    assert_response :success
  end

  test "should get destroy" do
    get department_assistant_destroy_url
    assert_response :success
  end

  test "should get enable" do
    get department_assistant_enable_url
    assert_response :success
  end

end
