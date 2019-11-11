require_relative './test'
require 'ostruct'

class TestCase < MiniTest::Test

  def mock_session(val = 'token123')
    OpenStruct.new(token: val)
  end
end
