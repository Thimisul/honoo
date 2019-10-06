require 'test_helper'

class EventTypesControllerTest < ActionDispatch::IntegrationTest
  test "should get get_event_type" do
    get event_types_get_event_type_url
    assert_response :success
  end

end
