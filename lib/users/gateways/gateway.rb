require_relative "../argchkr"
require_relative "../entities"

module Users
  module Gateways

    class Gateway
      include Users::ArgChkr
      include Users::Entities

      UserChkr = Policy.new(
        "user", ":% must be User entity",
        ->(v) { v.is_a? User})

      CredChkr = Policy.new(
        "credentials", ":% must be Credentials entity",
        ->(v) { v.is_a? Credentials})

      # Saves a new :user
      # @param user [User]
      # @return [User]
      def save_user(user)
        UserChkr.chk!(user)
      end

      # Finds a user by :uuid
      # @param uuid [String]
      # @return [User]
      def find_user(uuid)
      end

      # Returns collection of users
      # @param query [?]
      # @param order_by [?]
      # @param limit [Integer] number of users per data page
      # @param offset [Integer] number of page
      # @return [Array<User>] according to criteria above
      def select_users(query:, order_by:, limit:, offset:)
      end

      # Finds a user by :email
      # @param email [String]
      # @return [User]
      def find_user_by_email(email)
      end

      # Saves user credentials
      # @param cred [Credentials]
      # @return [Credentials]
      def save_credentials(cred)
        CredChkr.chk!(cred)
      end

      # Finds user credentials
      # @param email [String]
      # @return [Credentials]
      def find_credentials(email)
      end

    end

  end
end
