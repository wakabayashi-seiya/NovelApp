require 'test_helper'

class StoriesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get stories_new_url
    assert_response :success
  end

end
