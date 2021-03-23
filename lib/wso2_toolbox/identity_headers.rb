require 'active_support'

module Wso2Toolbox
  module IdentityHeaders
    extend ActiveSupport::Concern

    included do
      before_action :set_paper_trail_whodunnit
    end

    def user_identifier
      user_header = request.headers[:HTTP_USER_IDENTIFIER]
      user_header ? Base64.decode64(user_header) : nil
    end

    def user_for_paper_trail
      user_identifier
    end
  end
end
