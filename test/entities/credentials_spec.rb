require_relative "../spec_helper"
include Users::Entities

describe Credentials do

  let(:email) { "a@b.c" }
  let(:passw) { "KWYie2N8Ri" }
  let(:new_passw) { "987654321" }

  describe '#new' do

    it 'must create an instance' do
      cred = Credentials.new(email: email, password: passw)
      _(cred.email).must_equal email
      _(passw).must_equal cred.password
    end

    it 'must raise ArgumentError for invalid arguments' do
      _(->{ Credentials.new(email: email, password: "short") }
      ).must_raise ArgumentError

      _(->{ Credentials.new(email: "wrong", password: passw) }
      ).must_raise ArgumentError
    end
  end

  describe '#change_password' do
    it 'must change password' do
      cred = Credentials.new(email: email, password: passw)
      cred.change_password(old_password: passw, new_password: new_passw)
      _(new_passw).must_equal cred.password
    end

    it 'must raise ArgumentError for invalid new_password' do
      cred = Credentials.new(email: email, password: passw)
      _(->{ cred.change_password(old_password: passw, new_password: 123) }
      ).must_raise ArgumentError
    end

    it 'must raise Users::Error for invalid old_password' do
      cred = Credentials.new(email: email, password: passw)
      _(->{ cred.change_password(old_password: "passw", new_password: new_passw) }
      ).must_raise Users::Error
    end
  end

end
