require 'wso2_toolbox/version'
require 'wso2_toolbox/identity_headers'
require 'wso2_toolbox/configuration'
require 'wso2_toolbox/token_manager'
require 'wso2_toolbox/token_manager/api_manager_service'
require 'wso2_toolbox/token_manager/adapters/local_file_adapter'

module Wso2Toolbox
  class << self
    def reset
      @configuration = Configuration.new
    end

    def configuration
      @configuration ||= Configuration.new
    end

    def configure
      yield(configuration)
    end
  end
end
