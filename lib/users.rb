# frozen_string_literal: true

require_relative "users/version"
require_relative "users/entities"
require_relative "users/services"
require_relative "users/gateways"
require_relative "users/argchkr"

module Users
  class Error < StandardError; end

  class << self

    def authenticate_user(email:, password:)
      Services::AuthenticateUser.(
        email: email, password: password)
    end

    def create_user(name:, email:, password:)
      Services::RegisterUser.(
        name: name, email: email, password: password)
    end

    def change_user_password(email:, old_password:, new_password:)
      Services::ChangeUserPassword.(email: email,
        old_password: old_password, new_password: new_password)
    end

    def select_users(query: [], order_by: [], limit: 25, offset: 0)
      Services::SelectUsers.(query: query, order_by: order_by,
        limit: limit, offset: offset)
    end

    def error!(message)
      raise Error.new(message)
    end

    def root
      File.dirname __dir__
    end

    # Clone source code to another gem
    # @param path [String] the root folder of the gem to copy
    def clone_cleon_code(path = Dir.pwd)
      Users::Services::CloneCleonCode.(path)
    end

    CleonGateway = Users::ArgChkr::Policy.new(
      "gateway", ":%s must be Users::Gateways::Gateway",
      Proc.new {|v| v.is_a? Users::Gateways::Gateway})

    def gateway
      @gateway # ||= Users::Gateways::Gateway.new
    end

    def gateway=(gateway)
      @gateway = CleonGateway.chk!(gateway)
    end
  end
end
