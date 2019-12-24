require_relative '../../test_case'

class MovementFactoryTest < TestCase

  def test_create
    input = 'w'.ord

    key = Command::Factory::Movement::KEY_TO_DIRECTION_MAP.keys.sample
    expected_direction = Command::Factory::Movement::KEY_TO_DIRECTION_MAP[key]

    keymap = mock
    keymap.expects(:key_of).with(input).returns(key)

    expected = {
      type: :movement,
      direction: expected_direction
    }

    factory = Command::Factory::Movement.new(keymap: keymap)
    actual = factory.create(input)

    assert_equal(expected, actual)
  end

  def test_unmapped_key
    input = 'w'.ord

    keymap = mock
    keymap.expects(:key_of).with(input).returns(:menu_up)

    factory = Command::Factory::Movement.new(keymap: keymap)

    err = assert_raises(ArgumentError) do
      factory.create(input)
    end

    assert_equal('No direction for input ' + input.chr, err.message)
  end

  def test_supports
    cases = {
      'w' => true,
      'n' => false
    }

    keymap = mock
    cases.each do |key, expected|
      keymap.expects(:any?).with(key, [:up, :down, :left, :right]).returns(expected)
    end

    factory = Command::Factory::Movement.new(keymap: keymap)

    cases.each do |key, expected|
      assert(expected == factory.supports?(key))
    end
  end
end
