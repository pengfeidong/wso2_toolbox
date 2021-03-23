# forzen_string_literal: true

require 'json'
require 'request_store'
require 'active_support/core_ext/numeric/time'

module Wso2Toolbox
  module TokenManager
    module Adapters
      module LocalFileAdapter
        class << self
          TOKEN_DELAY = 5.minutes

          def generate_token
            new_token unless active_token?
            store_token(read(:token_for_job))
          end

          private_class_method

          def new_token
            token_params =
              Wso2Toolbox::TokenManager::ApiManagerService.create_token

            write(:token_time_for_job,
                  Time.now + token_params[:expires_in].seconds)
            write(:token_for_job,
                  "#{token_params[:token_type]} #{token_params[:access_token]}")
          end

          def store_token(token)
            RequestStore.store[:token] = token
          end

          def active_token?
            return false unless read(:token_time_for_job)
            Time.parse(read(:token_time_for_job)) - TOKEN_DELAY > Time.now
          end

          def read(key)
            local_storage { |store| return store.try(:[], key.to_s) }
          end

          def write(key, value)
            local_storage { |store| store[key] = value }
          end

          def local_storage
            file = File.open(file_path, 'a+').read
            file_read = file == '' ? '{}' : file

            local_store = JSON.parse(file_read)
            yield(local_store)

            File.open(file_path, 'w+') do |f|
              f.write(local_store.to_json)
              f.rewind
            end
          end

          def file_path
            @file_path ||= 'tmp/localstorage.json'
          end
        end
      end
    end
  end
end
