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

    snapshot_history = mock
    snapshot_history.expects(:clear)

    listener = Event::Listener::Connection.new(
      default_connection: connection,
      menu_system: menu,
      session: session,
      config: config,
      snapshot_history: snapshot_history
    )
    listener.on_disconnection({})
  end
end
