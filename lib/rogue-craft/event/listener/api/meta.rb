class Event::Listener::Meta < Handler::TokenAwareHandler

  include Dependency[:menu_system]

  def on_validate_token(event)
    send_msg(target: 'meta/validate_token') do |response|
      if response.code?(RPC::Code::OK)
        @menu_system.open_logged_in
      else
        @session.clear
        @menu_system.open_main
      end
    end
  end
end
