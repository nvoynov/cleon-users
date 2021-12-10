require_relative "../spec_helper"
require_relative "memory_gateway"
include Users::Services

describe ChangeUserPassword do
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
    let(:newpw) { "abcdefgh" }

    it 'must change password' do
      RegisterUser.(name: uname, email: email, password: passw)
      cred = ChangeUserPassword.(email: email,
        old_password: passw, new_password: newpw)
      _(newpw).must_equal cred.password
    end

    it 'must return ArgumentError for wrong :new_password' do
      RegisterUser.(name: uname, email: email, password: passw)
      _(->{ ChangeUserPassword.(email: email,
               old_password: passw,
               new_password: "short")
      }).must_raise ArgumentError
    end

    it 'must return Users::Error for wrong email' do
      RegisterUser.(name: uname, email: email, password: passw)
      _(->{ ChangeUserPassword.(email: "unknown",
               old_password: passw,
               new_password: newpw)
      }).must_raise Users::Error
    end

    it 'must return Users::Error for wrong password' do
      RegisterUser.(name: uname, email: email, password: passw)
      _(->{ ChangeUserPassword.(email: email,
               old_password: "wrong",
               new_password: newpw)
      }).must_raise Users::Error
    end
  end

end
