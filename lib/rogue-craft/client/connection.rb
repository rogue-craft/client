class Client::Connection < EventMachine::Connection
  def initialize(event)
    @event = event
  end

  def post_init
    start_tls
  end

  def ssl_handshake_completed
    # p "hello"
  end

  def unbind(reason = nil)
    if reason.is_a?(Exception)
      raise reason
    else
      # raise Exception.new(reason)
    end
    # @TODO publish event?
  end

  def receive_data(raw)
    @event.publish(:receive_data, {raw: raw, connection: self})
  end
end
