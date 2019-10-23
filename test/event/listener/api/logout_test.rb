require_relative '../../../test'


class LogoutTest < MiniTest::Test

  def test_happy_path
    dispatcher = mock
    dispatcher.expects(:dispatch).with do |msg|
      assert_equal('auth/logout', msg.target)
    end

    session = mock
    session.expects(:clear)

    listener = Event::Listener::Auth.new(message_dispatcher: dispatcher, session: session)
    listener.on_logout
  end
end
