class Event::Listener::Join < Handler::AuthenticatedHandler

  include Dependency[:game_state, :menu_system]

  def on_join_game(_)
    send_msg(target: 'world/start_stream') do |msg|
      @game_state.join_game
      @game_state.close_menu
      @menu_system.clear
    end
  end
end
