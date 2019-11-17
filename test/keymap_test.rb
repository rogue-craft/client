require_relative 'test'

class KeymapTest < MiniTest::Test

  def test_match
    map = Keymap.new

    assert(map.is?('w'.ord, :up))
    assert(false == map.is?('w'.ord, :unknown_type))
  end
end
