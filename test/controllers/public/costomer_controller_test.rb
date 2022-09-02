require "test_helper"

class Public::CostomerControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get public_costomer_show_url
    assert_response :success
  end

  test "should get edit" do
    get public_costomer_edit_url
    assert_response :success
  end
end
