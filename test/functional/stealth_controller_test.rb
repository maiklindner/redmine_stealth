require File.dirname(__FILE__) + '/../test_helper'

class StealthControllerTest < ActionController::TestCase
  fixtures :users
  if Redmine::VERSION::MAJOR >= 3
    fixtures :email_addresses
  end

  def setup
    user = User.last
    user.stealth_allowed = true
    user.save!

    @request.session[:user_id] = user.id
    User.current = user
  end

  def test_toggle_on_stealth_mode
    RedmineStealth.decloak!
    put :toggle
    assert_response :success
    assert RedmineStealth.cloaked?
  end

  def test_toggle_off_stealth_mode
    RedmineStealth.cloak!
    put :toggle
    assert_response :success
    assert !RedmineStealth.cloaked?
  end

  def test_enable_stealth_mode
    RedmineStealth.decloak!
    put :toggle, :toggle => 'true'
    assert_response :success
    assert RedmineStealth.cloaked?
  end

  def test_disable_stealth_mode
    RedmineStealth.cloak!
    put :toggle, :toggle => 'false'
    assert_response :success
    assert !RedmineStealth.cloaked?
  end
end
