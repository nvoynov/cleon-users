require_relative "../spec_helper"
include Users::Services
include Users::Entities

describe ChangeUserPassword do
  let(:email) { "a@b.c" }
  let(:new_password) { "newpa$$w0rd" }
  let(:old_password) { "pa$$w0rd" }
  let(:cred) { {email: email, password: old_password} }
  let(:cred_obj) { Credentials.new(**cred) }
  let(:args) {
    {email: email, old_password: old_password, new_password: new_password}
  }

  describe '#call' do
    it 'must change password' do
      @gateway = Minitest::Mock.new
      @gateway.expect(:find_credentials, cred_obj, [String])
      @gateway.expect(:save_credentials, cred_obj, [Credentials])

      Users.stub :gateway, @gateway do
        crd = ChangeUserPassword.(**args)
        assert crd
        assert_instance_of Credentials, crd
      end
    end

    let(:wrong_args) {
      {email: email, old_password: "wrong_old", new_password: new_password}
    }

    it 'must raise Users::Error for wrong password' do
      @gateway = Minitest::Mock.new
      @gateway.expect(:find_credentials, cred_obj, [String])
      @gateway.expect(:save_credentials, cred_obj, [Credentials])

      Users.stub :gateway, @gateway do
        assert_raises(Users::Error) { ChangeUserPassword.(**wrong_args) }
      end
    end
  end

  describe '#new' do
    # TODO: check arguments inside the service!
    #       and after that uncomment those tests
  #   it 'must raise ArgumentError for wrong arguments' do
  #     [nil, 1, "", "abcdd"].each do |wrng|
  #       assert_raises(ArgumentError) {
  #         ChangeUserPassword.(email: email,
  #           old_password: wrng,
  #           new_password: new_password)
  #       }
  #     end
  #     [nil, 1, "", "abcdd"].each do |wrng|
  #       assert_raises(ArgumentError) {
  #         ChangeUserPassword.(email: email,
  #           old_password: old_password,
  #           new_password: wrng)
  #       }
  #     end
  #   end
  #
  end

end
