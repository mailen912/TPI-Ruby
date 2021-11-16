require "test_helper"

class AppointmentsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get appointments_show_url
    assert_response :success
  end

  test "should get destroy" do
    get appointments_destroy_url
    assert_response :success
  end
end
