require_relative './test'
require 'ostruct'

class TestCase < MiniTest::Test

  def mock_session(token: 'token123', logged_in: true)
    session = mock
    session.expects(:token).at_most(10).returns(token)
    session.expects(:logged_in?).at_most(10).returns(logged_in)

    session
  end
end
