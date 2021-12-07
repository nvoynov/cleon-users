require_relative "service"
require_relative "../entities"

module Users
  module Services

    class ChangeUserPassword < Service
      include Users::Entities

      def initialize(email:, old_password:, new_password:)
        @email = email
        @old_password = old_password
        @new_password = new_password
      end

      def call
        cred = gateway.find_credentials(@email)
        raise Users::Error, "Unknow user or password" unless cred
        cred.change_password(
          old_password: @old_password,
          new_password: @new_password)
        gateway.save_credentials(cred)
      end
    end

  end
end
