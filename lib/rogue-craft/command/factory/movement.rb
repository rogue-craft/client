class Command::Factory::Movement

  include Dependency[:keymap]

  KEY_TO_DIRECTION_MAP = {
    up: Interpolation::Direction::NORTH,
    down: Interpolation::Direction::SOUTH,
    left: Interpolation::Direction::WEST,
    right: Interpolation::Direction::EAST
  }.freeze

  def supports?(input)
    @keymap.any?(input, KEY_TO_DIRECTION_MAP.keys)
  end

  def create(input)
    {
      type: :movement,
      direction: direction_of(input)
    }
  end

  private
  def direction_of(input)
    direction = KEY_TO_DIRECTION_MAP[@keymap.key_of(input)]

    raise ArgumentError.new('No direction for input ' + input.chr) unless direction

    direction
  end
end
