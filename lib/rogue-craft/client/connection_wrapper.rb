class Client::ConnectionWrapper
  def initialize(underlying = nil)
    @underlying = nil

    self.underlying = underlying if underlying
  end

  def send_data(data)
    @underlying.send_data(data)
  end

  def close_connection
    @underlying&.close_connection
  end

  def underlying=(underlying)
    raise ArgumentError.new("Underlying connection must be a #{Client::Connection.name}") unless underlying.is_a?(Client::Connection)

    @underlying = underlying
  end
end
