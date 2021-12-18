require_relative "../spec_helper"
include Users::Services
include Users::Entities

=begin
When I rewrote services tests using mocks and stubs and then threw away MemoryGateway (created there precisely to test services), I caught a glimpse of CQRS.

The RegisterUser, AuthenticateUser, and ChangeUserPassword services are "Commands", that really have some business logic. At the same time,  SelectUsers is just a "Query" that has no logic and just plays as a bridge between the service's consumer and the data gateway; it just passes params to the gateway and returns the gateway response to the consumer.

So, in this case, for this particular "query" service, only argument checking policies should be tested, and maybe the fact that service just return the gateway answer. And creating a gateway for test purposes at the domain business logic level might be just waste of time, but let's look into it again at the interface layer of the domain service.
=end

describe SelectUsers do
  describe '#new' do
  end

  describe '#call' do
    it 'must return the gateway response' do
      @gateway = Minitest::Mock.new
      @gateway.expect(:select_users, 42, [Hash])
      Users.stub :gateway, @gateway do
        response = SelectUsers.(**{})
        assert response
        assert_equal response, 42
      end
    end
  end

end
