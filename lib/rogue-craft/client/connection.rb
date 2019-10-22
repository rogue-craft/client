class Client::Connection < EventMachine::Connection

  def post_init
    start_tls
  end

  def ssl_handshake_completed
    # p "HelloClient"
  end

  def unbind(reason)
    raise Exception.new(reason.to_s)

    # @game_loop.close(reason)
  end

  def receive_data(raw)
    event.publish(:receive_data, {raw: raw, connection: self})
  end

  def event
    @event ||= Dependency.container.resolve(:event)
  end
end
