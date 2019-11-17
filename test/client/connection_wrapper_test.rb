require_relative '../test'

class ConnectionWrapperTest < MiniTest::Test

  def test_delegation
    underlying = create_underlying
    underlying.expects(:send_data).with('test')
    underlying.expects(:close_connection)

    wrapper = Client::ConnectionWrapper.new(underlying)
    wrapper.send_data('test')
    wrapper.close_connection
  end

  def test_delegation_with_setter
    underlying = create_underlying
    underlying.expects(:send_data).with('test')
    underlying.expects(:close_connection)

    wrapper = Client::ConnectionWrapper.new
    wrapper.underlying = underlying
    wrapper.send_data('test')
    wrapper.close_connection
  end

  def test_invalid_underlying_connection
    assert_raises(ArgumentError) do
      Client::ConnectionWrapper.new('test')
    end

    wrapper = Client::ConnectionWrapper.new

    assert_raises(ArgumentError) do
      wrapper.underlying = 123
    end
  end

  def test_optional_close_connection
    wrapper = Client::ConnectionWrapper.new(nil)
    wrapper.close_connection

    wrapper.underlying = create_underlying
    wrapper.expects(:close_connection)
    wrapper.close_connection
  end

  private
  def create_underlying
    underlying = mock
    underlying.expects(:is_a?).with(Client::Connection).returns(true)
    underlying
  end
end
