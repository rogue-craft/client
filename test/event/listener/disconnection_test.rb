require_relative '../../test_case'

class DisconnectTest < TestCase

  def test_disconnection
    connection = mock
    connection.expects(:close_connection)

    menu = mock
    menu.expects(:open_servers)

    session = mock
    session.expects(:close)

    config = mock
    config.expects(:unselect_server)

    listener = Event::Listener::Connection.new(default_connection: connection, menu_system: menu, session: session, config: config)
    listener.on_disconnection({})
  end
end
