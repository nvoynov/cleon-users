require_relative "../../lib/users/gateways/gateway"

class MemoryGateway < Users::Gateways::Gateway
  def initialize
    @storage = {}
    @storage[:users] = {}
    @storage[:creds] = {}
  end

  # Saves a new :user
  # @param user [User]
  # @return [User]
  def save_user(user)
    super(user)
    @storage[:users][user.uuid] = user
    user
  end

  # Finds a user by :uuid
  # @param uuid [String]
  # @return [User]
  def find_user(uuid)
    super(uuid)
    @storage[:users][uuid]
  end

  # Finds a user by :email
  # @param email [String]
  # @return [User]
  def find_user_by_email(email)
    user = @storage[:users].values.find {|u| u.email == email}
    user
  end

  # Returns collection of users
  # @param query [?]
  # @param order_by [?]
  # @param limit [Integer] number of users per data page
  # @param offset [Integer] number of page
  # @return [Array<User>] according to criteria above
  def select_users(query:, order_by:, limit:, offset:)
    limit = MAX_LIMIT if limit > MAX_LIMIT
    # TODO: apply query
    # TODO: apply order_by
    @storage[:users].values[offset * limit, limit]
  end

  MAX_LIMIT = 25

  # Saves user credentials
  # @param cred [Credentials]
  # @return [Credentials]
  def save_credentials(cred)
    super(cred)
    @storage[:creds][cred.email] = cred
    cred
  end

  # Finds user credentials
  # @param email [String]
  # @return [Credentials]
  def find_credentials(email)
    super(email)
    @storage[:creds][email]
  end

end