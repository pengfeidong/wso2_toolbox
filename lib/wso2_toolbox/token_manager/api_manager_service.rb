# frozen_string_literal: true

require 'rest-client'

module Wso2Toolbox
  module TokenManager
    module ApiManagerService
      class << self
        def create_token
          post(build_params)
        end

        private_class_method

        def config
          @config ||= Wso2Toolbox.configuration
        end

        def build_params
          {
            username: config.token_username,
            password: config.token_password
          }
        end

        def post(params)
          response = RestClient.post(config.token_url, params.to_json,
                                     content_type: :json)
          JSON.parse(response).with_indifferent_access
        end
      end
    end
  end
end
