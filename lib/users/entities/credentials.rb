require_relative "entity"

require 'bcrypt'

module Users
  module Entities

    class Credentials < Entity
      include BCrypt
      # TODO: it was a bad idea to hold it here
      #  1) there must be only final attributes email, password_hash
      #  and no password hashing logic
       # 2) password hashig logic must be moved to registration_service, and there should be introduced CryptoProvider (and maybe PasswordPolicy also)
      # hash = BCrypt::Password.create(secret)
      # pasw = BCrypt::Password.new(hash)
      # pasw == secret NOT secret == passw

      attr_reader :email
      attr_reader :password_hash

      def initialize(email:, password:, password_hash: nil)
        @email = EmailChkr.chk!(email)
        if password_hash
          @password_hash = password_hash
        else
          PasswordChkr.chk!(password)
          @password_hash = Password.create(password)
        end
      end

      def password
        @password ||= Password.new(@password_hash)
      end

      def change_password(old_password:, new_password:)
        PasswordChkr.chk!(new_password)
        raise Users::Error.new("Unknow user or password"
        ) unless password == old_password
        @password_hash = Password.create(new_password)
        @password = nil
      end
    end

  end
end
