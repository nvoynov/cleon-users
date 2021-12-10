require_relative "service"
require_relative "../entities"

module Users
  module Services

    class SelectUsers < Service
      include Users::Entities

      def initialize(query: [], order_by: [], limit: 25, offset: 0)
        @limit = MoreThanZero.chk!(limit, name: "limit")
        @limit = 25 if @limit > 25
        @offset = offset
        # TODO: what shuld be format for :query and :order_by?
        @query = query
        @order_by = order_by
      end

      # @return [Array] @see Users::Gateways::Gateway#select_users
      def call
        gateway.select_users(
          query: @query, order_by: @order_by,
          limit: @limit, offset: @offset)
      end
    end

  end
end
