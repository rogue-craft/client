class Event::Listener::Connection < Handler::TokenAwareHandler

  include Dependency[:menu_system, :config, :event, :default_connection]

  def on_server_selection(event)
    @config.select_server(event[:server])

    @default_connection.close_connection
    @default_connection.underlying = EM::connect(@config[:ip], @config[:port], Client::Connection)

    unless @session.logged_in?
      @menu_system.open_main
      return
    end

    check_token_validity
  end

  private
  def check_token_validity
    send_msg(target: 'meta/ping') do |response|
      if response.code?(RPC::Code::OK)
        @menu_system.open_logged_in
      else
        @session.clear
        @menu_system.open_main
      end
    end
  end

  public
  def on_disconnection(event)
    @default_connection.close_connection

    @menu_system.open_servers
  end
end
