require 'test_helper'

class PaymentControllerTest < ActionDispatch::IntegrationTest
  test "should get callback" do
    get payment_callback_url
    assert_response :success
  end

end
