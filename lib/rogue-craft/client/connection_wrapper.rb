class Client::ConnectionWrapper

  def initialize(underlying = nil)
    @underlying = nil

    if underlying
      self.underlying = underlying
    end
  end

  def send_data(data)
    @underlying.send_data(data)
  end

  def close_connection
    if @underlying
      @underlying.close_connection
    end
  end

  def underlying=(underlying)
    unless underlying.is_a?(Client::Connection)
      raise ArgumentError.new("Underlying connection must be a #{Client::Connection.name}")
    end

    @underlying = underlying
  end
end
