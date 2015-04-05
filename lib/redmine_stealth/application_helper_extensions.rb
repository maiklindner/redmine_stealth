require_dependency 'application_helper'

module RedmineStealth
  module CssHelper
    def self.included(base) # :nodoc:
      base.send(:include, InstanceMethods)

      base.class_eval do
        unloadable
        alias_method_chain :body_css_classes, :stealth
      end
    end

    module InstanceMethods
      def body_css_classes_with_stealth
        css = body_css_classes_without_stealth || ''
        if RedmineStealth.cloaked?
          css += ' stealth'
        end
        css
      end
    end
  end
end

ApplicationHelper.send(:include, RedmineStealth::CssHelper)
