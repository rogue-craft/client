require_relative '../../../test'


class LogoutTest < MiniTest::Test

  def test_happy_path
    dispatcher = mock
    dispatcher.expects(:dispatch).yields.with do |msg|
      assert_equal('auth/logout', msg.target)
    end

    session = mock
    session.expects(:clear)

    menu = mock
    menu.expects(:open_main).once

    listener = Event::Listener::Auth.new(message_dispatcher: dispatcher, session: session, menu_system: menu)
    listener.on_logout
  end
end
