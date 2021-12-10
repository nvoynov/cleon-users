require_relative "../spec_helper"
require_relative "memory_gateway"
include Users::Services

describe RegisterUser do
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
    let(:passw) { "pa$$w0rd"}

    it 'must create user' do
      user = RegisterUser.(name: uname, email: email, password: passw)
      _(user).wont_be_nil
      _(user.uuid).wont_be_nil
      _(user.name).must_equal uname
      _(user.email).must_equal email

      user = Users.gateway.find_user(user.uuid)
      _(user.name).must_equal uname
      _(user.email).must_equal email

      cred = Users.gateway.find_credentials(user.email)
      _(cred).wont_be_nil
    end

    it 'must raise Users::Error when email already used' do
      RegisterUser.(name: uname, email: email, password: passw)
      _(->{
           RegisterUser.(name: "new", email: email, password: passw)
        }).must_raise Users::Error
    end
  end
end
