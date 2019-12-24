require_relative 'test'

class KeymapTest < MiniTest::Test

  def test_key_by_input
    map = Keymap.new

    assert(:up, map.key_of('w'.ord))
    assert_nil(map.key_of('test'))
  end

  def test_match
    map = Keymap.new

    assert(map.is?('w'.ord, :up))
    assert(false == map.is?('w'.ord, :unknown_type))
  end

  def test_any?
    map = Keymap.new

    assert(map.any?('w'.ord, [:down, :up]))
    assert(false == map.any?('q'.ord, [:down, :up]))
  end
end
