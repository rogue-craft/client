require_relative './test'
require 'ostruct'

class TestCase < MiniTest::Test

  def stub_session(token: 'token123')
    OpenStruct.new(token: token)
  end
end
