require File.expand_path('../../test_helper', __FILE__)

class RedmineStealthTest < ActiveSupport::TestCase
  include Redmine::I18n

  fixtures :users
  if Redmine::VERSION::MAJOR >= 3
    fixtures :email_addresses
  end

  def setup
    user = User.last
    user.stealth_allowed = true
    user.save!
    User.current = user
  end

  def test_cloak_decloak
    assert !RedmineStealth.cloaked?
    RedmineStealth.cloak!
    assert RedmineStealth.cloaked?

    RedmineStealth.decloak!
    assert !RedmineStealth.cloaked?
  end

  def test_toggle_stealth
    assert !RedmineStealth.cloaked?
    RedmineStealth.toggle_stealth_mode!
    assert RedmineStealth.cloaked?
    RedmineStealth.toggle_stealth_mode!
    assert !RedmineStealth.cloaked?
  end

  def test_javascript_toggle_statement
    msg_dis = l(RedmineStealth::MESSAGE_ACTION_DECLOAK).to_json
    msg_ena = l(RedmineStealth::MESSAGE_ACTION_CLOAK).to_json

    RedmineStealth.cloak!
    assert_equal "RedmineStealth.cloak(#{msg_dis});", RedmineStealth.javascript_toggle_statement
    RedmineStealth.decloak!
    assert_equal "RedmineStealth.decloak(#{msg_ena});", RedmineStealth.javascript_toggle_statement
  end

  def test_failed_message_translator
    msg = RedmineStealth::FailedMessageTranslator.new
    assert_equal l(RedmineStealth::MESSAGE_TOGGLE_FAILED), msg.to_s
  end
end
