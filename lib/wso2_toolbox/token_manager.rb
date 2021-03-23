# frozen_string_literal: true

require 'active_support/core_ext/numeric/time'

module Wso2Toolbox
  module TokenManager
    def self.generate_token
      if defined?(RailsSettings)
        TokenManager::Adapters::RailsCachedAdapter.generate_token
      else
        TokenManager::Adapters::LocalFileAdapter.generate_token
      end
    end
  end
end
