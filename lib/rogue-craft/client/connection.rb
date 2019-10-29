class Client::Connection < EventMachine::Connection

  def post_init
    start_tls
  end

  def ssl_handshake_completed
    # p "HelloClient"
  end

  def unbind(reason = nil)
    raise Exception.new(reason.to_s)
  end

  def receive_data(raw)
    event.publish(:receive_data, {raw: raw, connection: self})
  end

  def event
    @event ||= Dependency.container.resolve(:event)
  end
end
