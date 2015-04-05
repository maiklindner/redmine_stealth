require_dependency 'redmine_stealth'
require_dependency 'redmine_stealth/mail_interceptor'
require_dependency 'redmine_stealth/hooks'
require_dependency 'redmine_stealth/application_helper_extensions'
require_dependency 'redmine_stealth/user_extensions'

Redmine::Plugin.register :redmine_stealth do
  name        'Redmine Stealth plugin'
  author      'Riley Lynch et al.'
  description 'Enables users to disable Redmine email notifications for their actions'
  version     '0.6.0'
  url         'https://github.com/dr-itz/redmine_stealth '
  author_url  'http://github.com/teleological'

  permission :toggle_stealth_mode, :stealth => :toggle

  toggle_url = { :controller => 'stealth', :action => 'toggle' }

  decide_toggle_display = lambda do |*_|
    user = ::User.current
    user.allowed_to?(toggle_url, nil, :global => true) && user.stealth_allowed?
  end

  stealth_menuitem_captioner = lambda do |project|
    RedmineStealth.status_label
  end

  menu :account_menu, :stealth, toggle_url, {
    :first    => true,
    :if       => decide_toggle_display,
    :caption  => stealth_menuitem_captioner,
    :html => {
        'id' => 'stealth_toggle',
        'remote' => true, 'method' => :post,
        'data-failure-message' => RedmineStealth::FailedMessageTranslator.new
    }
  }
end
