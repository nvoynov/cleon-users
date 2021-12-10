require_relative "service"
require_relative "../entities"

module Users
  module Services

    class RegisterUser < Service
      include Users::Entities

      def initialize(name:, email:, password:)
        @name = UserNameChkr.chk!(name)
        @email = EmailChkr.chk!(email)
        @password = PasswordChkr.chk!(password)
      end

      def call
        raise Users::Error.new(":email already used"
        ) if gateway.find_credentials(@email)
        cred = Credentials.new(email: @email, password: @password)
        user = User.new(name: @name, email: @email)
        gateway.save_credentials(cred)
        gateway.save_user(user) # => user
      end
    end

  end
end
