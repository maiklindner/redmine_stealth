class StealthController < ApplicationController
  unloadable

  before_filter :check_stealth_allowed

  def toggle
    if params[:toggle] == 'true'
      RedmineStealth.cloak!
    elsif params[:toggle] == 'false'
      RedmineStealth.decloak!
    else
      RedmineStealth.toggle_stealth_mode!
    end

    render :js => RedmineStealth.javascript_toggle_statement
  end

  private

  def check_stealth_allowed
    render_403 unless User.current.stealth_allowed
  end
end
