class Client::ConnectionWrapper

  def initialize(underlying = nil)
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
      raise ArgumentError.new("underlying must be a #{Client::Connection.name}")
    end

    @underlying = underlying
  end

  def initialized?
    nil != @underlying
  end
end
