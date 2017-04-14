require 'test_helper'

class ParsersControllerTest < ActionDispatch::IntegrationTest
  test "should get upload" do
    get parsers_upload_url
    assert_response :success
  end

end
