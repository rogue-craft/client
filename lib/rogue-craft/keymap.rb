class Keymap

  TAB = 9

  def initialize
    @keys = {
      menu_up: Ncurses::KEY_BTAB,
      menu_down: TAB,
      up: 'w'.ord,
      left: 'a'.ord,
      down: 's'.ord,
      right: 'd'.ord,
      enter: 10
    }.freeze
  end

  def [](key)
    @keys[key]
  end

  def camera_keys
    @keys.values_at(:up, :left, :down, :right)
  end
end
