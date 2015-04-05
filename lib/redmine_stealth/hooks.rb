module RedmineStealth
  class Hooks < Redmine::Hook::ViewListener
    def controller_account_success_authentication_after(context={})
      ::RedmineStealth.decloak!
    end

    def view_layouts_base_html_head(context={})
      stylesheet_link_tag('stealth', :plugin => 'redmine_stealth') +
      javascript_include_tag('stealth.js', :plugin => 'redmine_stealth')
    end

    def view_layouts_base_body_bottom(context={})
      init_state = RedmineStealth.javascript_toggle_statement
      javascript_tag("jQuery(function($) { #{init_state} });")
    end

    render_on :view_users_form, :partial => 'hooks/stealth_settings'
    render_on :view_my_account, :partial => 'hooks/stealth_settings'
  end
end
