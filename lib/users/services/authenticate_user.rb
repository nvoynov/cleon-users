require_relative "service"
require_relative "../entities"

module Users
  module Services

    class AuthenticateUser < Service
      include Users::Entities

      def initialize(email:, password:)
        @email = EmailChkr.chk!(email)
        @password = PasswordChkr.chk!(password)
      end

      def call
        cred = gateway.find_credentials(@email)
        Users.error!("Unknow user or password"
        ) unless cred && cred.password == @password
        user = gateway.find_user_by_email(@email)
        Users.error!("Unknow user or password") unless user
        user
      end
    end

  end
end
