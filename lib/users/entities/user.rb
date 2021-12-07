require_relative "entity"

module Users
  module Entities

    class User < Entity
      attr_reader :uuid
      attr_reader :name
      attr_reader :email

      def initialize(uuid: nil, name: , email: )
        uuid = SecureRandom.uuid unless uuid
        @uuid = uuid
        @name = UserNameChkr.chk!(name)
        @email = EmailChkr.chk!(email) 
      end
    end

  end
end
