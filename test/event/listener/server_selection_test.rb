require_relative '../../test_case'

class ServerSelectionTest < TestCase

  def test_no_token
    menu = mock
    menu.expects(:open_main)

    run_test(mock_session(logged_in: false), menu)
  end

  def test_has_valid_token
    menu = mock
    menu.expects(:open_logged_in)

    dispatcher = mock_dispatcher(RPC::Code::OK)

    run_test(mock_session(logged_in: true), menu, dispatcher)
  end

  def test_has_invalid_token
    menu = mock
    menu.expects(:open_main)

    dispatcher = mock_dispatcher(RPC::Code::ACCESS_DENIED)

    session = mock_session(logged_in: true)
    session.expects(:clear)

    run_test(session, menu, dispatcher)
  end

  private

  def mock_dispatcher(code)
    response = RPC::Message.from(code: code)

    dispatcher = mock
    dispatcher.expects(:dispatch).yields(response).with do |msg|
      assert_equal('meta/ping', msg.target)
    end

    dispatcher
  end

  def run_test(session, menu_system, dispatcher = nil)
    event = {server: 'server'}

    session_seq = sequence('session')

    config = mock
    config.expects(:select_server).with(event[:server]).in_sequence(session_seq)
    config.expects(:[]).with(:ip).returns('ip')
    config.expects(:[]).with(:port).returns('port')

    session.expects(:start).in_sequence(session_seq)

    EM.expects(:connect).with('ip', 'port', Client::Connection).returns(:connection)

    connection = mock
    connection.expects(:close_connection)
    connection.expects(:underlying=).with(:connection)


    listener = Event::Listener::Connection.new(
      config: config,
      default_connection: connection,
      message_dispatcher: dispatcher,
      session: session,
      menu_system: menu_system
    )
    assert(listener.is_a?(Handler::AuthenticatedHandler))

    listener.on_server_selection(event)
  end
end
