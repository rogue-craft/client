class Event::Listener::Meta < Handler::TokenAwareHandler

  def on_validate_token(event)
    send_msg(target: 'meta/validate_token') do |response|
      if response.code?(RPC::Code::OK)
        event[:valid].call
      else
        event[:invalid].call
      end
    end
  end
end
