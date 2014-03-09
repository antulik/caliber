require 'css_parser'
module Caliber
  class CaliberController < Caliber::ApplicationController
    include ::CssParser

    layout 'caliber/application'

    before_filter :require_local!

    def index
      @css_selectors = []

      Rails.application.assets.each_file do |pathname|

        next unless Rails.application.assets.content_type_of(pathname) == 'text/css'

        parser = CssParser::Parser.new

        begin
          link = Rails.application.assets[pathname].to_s
          parser.add_block! link

          selectors = parser.to_enum(:each_selector).map do |selectors, declarations, specificity, media_types|
            declarations = declarations.gsub ";", ";<br>"
            {
                pathname: pathname.to_s,
                selector: selectors,
                declarations: declarations,
                specificity: specificity,
                media_types: media_types
            }
          end

          @css_selectors.concat selectors
        rescue
        end
      end
    end

    private
    def require_local!
      unless local_request?
        render :text => '<p>For security purposes, this information is only available to local requests.</p>', :status => :forbidden
      end
    end

    def local_request?
      Rails.application.config.consider_all_requests_local || request.local?
    end

  end
end

