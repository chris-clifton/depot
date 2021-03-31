# frozen_string_literal: true

require 'test_helper'

# Admin controller tests
class AdminControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get admin_url
    assert_response :success
  end
end
