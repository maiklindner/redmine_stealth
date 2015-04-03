require 'simplecov'

if Dir.pwd.match(/plugins\/redmine_stealth/)
  covdir = 'coverage'
else
  covdir = 'plugins/redmine_stealth/coverage'
end

SimpleCov.coverage_dir(covdir)
SimpleCov.start 'rails' do
  add_filter do |source_file|
    # only show files belonging to the plugin, except init.rb which is not fully testable
    source_file.filename.match(/redmine_stealth/) == nil ||
      source_file.filename.match(/redmine_stealth\/init.rb/) != nil
  end
end

# Load the Redmine helper
require File.expand_path(File.dirname(__FILE__) + '/../../../test/test_helper')
