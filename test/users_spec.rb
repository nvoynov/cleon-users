# frozen_string_literal: true

require_relative "spec_helper"
require_relative "services/memory_gateway"

describe Users do

  it 'must provide VERSION' do
    _(::Users::VERSION).wont_be_nil
  end

  # just to ensure that all servies works through Users.
  describe 'services' do
    before do
      @gateway ||= MemoryGateway.new
      Users.gateway = @gateway
    end

    it 'must create_user' do
      Users.create_user(name: "joe", email: "j@k.m", password: "pa$$w0rd")
    end

    it 'must authenticate_user' do
      Users.create_user(name: "joe", email: "j@k.m", password: "pa$$w0rd")
      user = Users.authenticate_user(email: "j@k.m", password: "pa$$w0rd")
      _(user).wont_be_nil
    end

    it 'must change_user_password' do
      Users.create_user(name: "joe", email: "j@k.m", password: "pa$$w0rd")
      Users.change_user_password(email: "j@k.m",
        old_password: "pa$$w0rd", new_password: "password")
    end

    it 'must select_users' do
      Users.select_users()
    end

  end

end
