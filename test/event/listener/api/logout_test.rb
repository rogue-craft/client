require_relative '../../../test'


class LogoutTest < MiniTest::Test

  def test_happy_path
    response = RPC::Message.from(code: RPC::Code::OK, params: {token: 'user-token'})

    dispatcher = mock
    dispatcher.expects(:dispatch).yields(response).with do |msg|
      assert_equal('auth/logout', msg.target)
    end

    session = mock
    session.expects(:clear)

    listener = Event::Listener::Auth.new(message_dispatcher: dispatcher, session: session)
    listener.on_logout
  end
end
