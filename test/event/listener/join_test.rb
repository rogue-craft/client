require_relative '../../test_case'

class JoinTest < TestCase

  def test_join_game
    response = RPC::Message.from

    dispatcher = mock
    dispatcher.expects(:dispatch).yields(response).with do |msg|
      assert_equal('world/start_stream', msg.target)
    end

    game_state = mock
    game_state.expects(:join_game).once
    game_state.expects(:close_menu).once

    menu_system = mock
    menu_system.expects(:clear).once

    assert(Event::Listener::Join < Handler::AuthenticatedHandler)

    listener = Event::Listener::Join.new(message_dispatcher: dispatcher, session: mock_session, game_state: game_state, menu_system: menu_system)
    listener.on_join_game({})
  end
end
