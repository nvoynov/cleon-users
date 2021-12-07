require_relative "entity"

require 'bcrypt'

module Users
  module Entities

    class Credentials < Entity
      include BCrypt
      # hash = BCrypt::Password.create(secret)
      # pasw = BCrypt::Password.new(hash)
      # pasw == secret NOT secret == passw

      attr_reader :email
      attr_reader :password_hash

      def initialize(email:, password:)
        @email = EmailChkr.chk!(email)
        PasswordChkr.chk!(password)
        @password_hash = Password.create(password)
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
