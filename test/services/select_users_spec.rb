require_relative "../spec_helper"
require_relative "memory_gateway"
include Users::Services

describe SelectUsers do
  before do
    @gateway ||= MemoryGateway.new.tap do |gateway|
      1.upto(76) do |counter|
        user = Users::Entities::User.new(
          name:  "name#{counter}",
          email: "a#{counter}@e.c")
        gateway.save_user(user)
      end
    end
    Users.gateway = @gateway
  end

  describe '#new' do
    it 'must check arguments'
  end

  describe '#call' do
    let(:limit) { 25 }

    it 'must return array<User>' do
      users = SelectUsers.(limit: limit, offset: 0)
      _(users).must_be_kind_of Array
      _(users.size).must_equal limit
    end

    it 'must return all users by pages' do
      lim = 20
      off = 0
      usr = []
      while u = SelectUsers.(limit: lim, offset: off)
        usr.concat(u)
        off += 1
      end
      _(usr.size).must_equal 76
    end

  end
end
