require_relative "../spec_helper"
require_relative "memory_gateway"
include Users::Services

describe SelectUsers do
  before do
    Users.gateway = MemoryGateway.new
  end

  describe '#new' do
    it 'must check arguments'
  end

  describe 'emtpy users' do
    it 'must return []' do
      users, meta = SelectUsers.()
      _(users).wont_be_nil Array
      _(users).must_be_kind_of Array
      _(users.empty?).must_equal true
      _(meta[:prev]).must_be_nil
      _(meta[:next]).must_be_nil
    end
  end

  describe 'users' do

    before do
      1.upto(76) do |counter|
        Users.gateway.save_user(
          Users::Entities::User.new(
            name:  "name#{counter}",
            email: "a#{counter}@e.c")
        )
    end

    let(:limit) { 25 }

    it 'must return array<User>' do
      users = SelectUsers.(limit: limit, offset: 0)[0]
      _(users).must_be_kind_of Array
      _(users.size).must_equal limit
    end

    it 'must return all users by pages' do
      lim = 20
      off = 0
      usr = []
      while u = SelectUsers.(limit: lim, offset: off)[0]
        usr.concat(u)
        off += 1
      end
      _(usr.size).must_equal 76
    end

    it 'must traverse users by meta[:next]' do
      lim = 20
      users, meta = gateway.select_users(limit: lim)
      while meta[:next]
       items, meta = gateway.select_users(
         Hash[meta].merge!({offset: meta[:next]}))
       users.concat(items)
      end
      _(users.size).must_equal 76
    end

  end
end
end
