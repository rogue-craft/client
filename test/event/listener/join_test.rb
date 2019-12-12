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

    assert(Event::Listener::Join < Handler::AuthenticatedHandler)

    listener = Event::Listener::Join.new(message_dispatcher: dispatcher, session: mock_session, game_state: game_state)
    listener.on_join_game({})
  end
end
