require "securerandom"
require_relative "../argchkr"

module Users
  module Entities

    class Entity
      include Users::ArgChkr

      protected

        def create_uuid
          SecureRandom.uuid
        end
    end

  end
end
