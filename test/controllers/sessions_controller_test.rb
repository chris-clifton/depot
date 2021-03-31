# frozen_string_literal: true

require 'test_helper'

# Session controller tests
class SessionsControllerTest < ActionDispatch::IntegrationTest
  test 'should prompt for login' do
    get login_url
    assert_response :success
  end

  test 'should login' do
    han_solo = users(:one)
    post login_url, params: { name: han_solo.name, password: 'secret'}
    assert_redirected_to admin_url
    assert_equal han_solo.id, session[:user_id]
  end

  test 'should fail login' do
    han_solo = users(:one)
    post login_url, params: { name: han_solo.name, password: 'notthepassword' }
    assert_redirected_to login_url
  end

  test 'should logout' do
    delete logout_url
    assert_redirected_to store_index_url
  end
end
