require 'test_helper'

class NovelsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get novels_new_url
    assert_response :success
  end
end
