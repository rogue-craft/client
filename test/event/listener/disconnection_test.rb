require_relative '../../test_case'

class DisconnectTest < TestCase

  def test_disconnection
    connection = mock
    connection.expects(:close_connection)

    menu = mock
    menu.expects(:open_servers)

    listener = Event::Listener::Connection.new(default_connection: connection, menu_system: menu)
    listener.on_disconnection({})
  end
end
