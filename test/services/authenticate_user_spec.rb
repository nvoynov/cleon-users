require_relative "../spec_helper"
include Users::Services
include Users::Entities

describe AuthenticateUser do
  describe '#new' do
    let(:email) { "a@b.c" }
    let(:passw) { "pa$$w0rd" }
    let(:wrong_emails) { [nil, 1, "a", "abcd@ab", "@abcd.e"] }
    let(:wrong_passws) { [nil, 1, "short"] }

    it 'must raise ArgumentError for wrong arguments' do
      wrong_emails.each do |wrng|
        assert_raises(ArgumentError) {
          AuthenticateUser.(email: wrng, password: passw)
        }
      end

      wrong_passws.each do |wrng|
        assert_raises(ArgumentError) {
          AuthenticateUser.(email: email, password: wrng)
        }
      end
    end
  end

  describe '#call' do
    let(:user) { {name: "user", email: "a@b.c"} }
    let(:cred) { {email: "a@b.c", password: "pa$$w0rd"} }
    let(:wrng) { {email: "a@b.c", password: "wrngpa$$w0rd"} }
    let(:user_obj) { User.new(**user) }
    let(:cred_obj) { Credentials.new(**cred) }

    it 'must return User for right credentials' do
      @gateway = Minitest::Mock.new
      @gateway.expect(:find_credentials, cred_obj, [String])
      @gateway.expect(:find_user_by_email, user_obj, [String])

      Users.stub :gateway, @gateway do
        usr = AuthenticateUser.(**cred)
        assert usr
        assert_instance_of User, usr
      end
    end

    it 'must raise Users::Error for unknown email' do
      @gateway = Minitest::Mock.new
      @gateway.expect(:find_credentials, nil, [String])
      @gateway.expect(:find_user_by_email, nil, [String])

      Users.stub :gateway, @gateway do
        assert_raises(Users::Error) { AuthenticateUser.(**cred) }
      end
    end

    it 'must raise Users::Error for wrong credentials' do
      @gateway = Minitest::Mock.new
      @gateway.expect(:find_credentials, cred_obj, [String])
      @gateway.expect(:find_user_by_email, nil, [String])

      Users.stub :gateway, @gateway do
        assert_raises(Users::Error) { AuthenticateUser.(**wrng) }
      end
    end
  end
end
