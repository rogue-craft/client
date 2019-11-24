class Event::Listener::Join < Handler::AuthenticatedHandler

  include Dependency[:game_state, :snapshot_history]

  def on_join_game(_)
    send_msg(target: 'world/start_stream') do |msg|
      @snapshot_history.push(msg[:snapshot])
      @game_state.join_game
    end
  end
end
