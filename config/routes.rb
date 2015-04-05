RedmineApp::Application.routes.draw do
  post '/stealth/toggle', :to => 'stealth#toggle'
end
