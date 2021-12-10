require_relative "../spec_helper"
require_relative "memory_gateway"
include Users::Services

describe AuthenticateUser do
  before do
    @gateway ||= MemoryGateway.new
    Users.gateway = @gateway
  end

  describe '#new' do
    it 'must check arguments'
  end

  describe '#call' do
    let(:uname) { "user" }
    let(:email) { "user@cleon.com" }
    let(:passw) { "pa$$w0rd" }

    it 'must authenticate and return user' do
      RegisterUser.(name: uname, email: email, password: passw)
      user = AuthenticateUser.(email: email, password: passw)
      _(user).wont_be_nil
    end

    it 'must return Users::Error for unknown email' do
      RegisterUser.(name: uname, email: email, password: passw)
      _(->{ AuthenticateUser.(email: "a@b.c", password: passw)
      }).must_raise Users::Error
    end

    it 'must return Users::Error for wrong password' do
      RegisterUser.(name: uname, email: email, password: passw)
      _(->{ AuthenticateUser.(email: email, password: "wrongpa$$")
        }).must_raise Users::Error
    end

  end

end
