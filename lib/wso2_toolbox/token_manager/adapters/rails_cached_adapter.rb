# frozen_string_literal: true

require 'active_support/core_ext/numeric/time'

module Wso2Toolbox
  module TokenManager
    module Adapters
      module RailsCachedAdaper
        class << self
          TOKEN_DELAY = 5.minutes

          def generate_token
            new_token unless active_token?
            store_token(Setting.token_for_job)
          end

          private_class_method

          def new_token
            token_params =
              Wso2Toolbox::TokenManager::ApiManagerService.create_token
            Setting.token_for_job =
              "#{token_params[:token_type]} #{token_params[:access_token]}"
            Setting.token_time_for_job =
              Time.now + token_params[:expires_in].seconds
          end

          def store_token(token)
            RequestStore.store[:token] = token
          end

          def active_token?
            return false unless Setting.token_time_for_job
            Time.parse(Setting.token_time_for_job) - TOKEN_DELAY > Time.now
          end
        end
      end
    end
  end
end
