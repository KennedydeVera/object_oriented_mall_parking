require "test_helper"

class ParkingAllocationsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get parking_allocations_index_url
    assert_response :success
  end

  test "should get create" do
    get parking_allocations_create_url
    assert_response :success
  end
end
