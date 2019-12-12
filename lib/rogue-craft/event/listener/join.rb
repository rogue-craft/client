class Event::Listener::Join < Handler::AuthenticatedHandler

  include Dependency[:game_state]

  def on_join_game(_)
    send_msg(target: 'world/start_stream') do |msg|
      @game_state.join_game
    end
  end
end
