require_relative "../spec_helper"
include Users::Services
include Users::Entities

describe AuthenticateUser do
  let(:user)  { "user"  }
  let(:email) { "a@b.c" }
  let(:passw) { "pa$$w0rd" }

  describe '#new' do

    it 'must raise ArgumentError for wrong arguments' do
      [nil, 1, "", "ab"].each do |wrng|
        assert_raises(ArgumentError) {
          RegisterUser.(name: wrng, email: email, password: passw)
        }
      end

      [nil, 1, "a", "abcd@ab", "@abcd.e"].each do |wrng|
        assert_raises(ArgumentError) {
          RegisterUser.(name: user, email: wrng, password: passw)
        }
      end

      [nil, 1, "short"].each do |wrng|
        assert_raises(ArgumentError) {
          RegisterUser.(name: user, email: email, password: wrng)
        }
      end
    end
  end

  describe '#call' do
    let(:sign) { {name: "user", email: email, password: passw} }
    let(:user) { {name: "user", email: email} }
    let(:cred) { {email: email, password: passw} }
    let(:user_obj) { User.new(**user) }
    let(:cred_obj) { Credentials.new(**cred) }

    # TODO: rather interesting one, because it saves data to gateway
    #       but for the place and time one does not need gateway impl
    #       it just calls few gateway methods
    it 'must register new user' do
      @gateway = Minitest::Mock.new
      @gateway.expect(:find_credentials, nil, [String])
      @gateway.expect(:save_credentials, cred_obj, [Credentials])
      @gateway.expect(:save_user, user_obj, [User])

      Users.stub :gateway, @gateway do
        usr = RegisterUser.(**sign)
        assert usr
        assert_instance_of User, usr
      end
    end

    it 'must raise Users::Error when email already registered' do
      @gateway = Minitest::Mock.new
      @gateway.expect(:find_credentials, cred_obj, [String])
      @gateway.expect(:save_credentials, cred_obj, [Credentials])
      @gateway.expect(:save_user, user_obj, [User])

      Users.stub :gateway, @gateway do
        assert_raises(Users::Error) { RegisterUser.(**sign) }
      end
    end
  end

end
