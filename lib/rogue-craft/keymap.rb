class Keymap
  TAB = 9

  def initialize
    @keys = {
      menu_up: ['up'],
      menu_down: ['down'],
      menu_right: [Ncurses::KEY_RIGHT],
      menu_left: [Ncurses::KEY_LEFT],
      start_of_line: [Ncurses::KEY_HOME],
      end_of_line: [360, Ncurses::KEY_END],
      up: ['w'.ord],
      left: ['a'.ord],
      down: ['s'.ord],
      right: ['d'.ord],
      submit: ['return'],
      backspace: [Ncurses::KEY_BACKSPACE],
      delete: [Ncurses::KEY_DC],
      escape: ['escape']
    }.freeze
  end

  def key_of(input)
    @keys.find { |_, values| values.include?(input) }&.first
  end

  def is?(val, key)
    @keys.fetch(key, []).include?(val)
  end

  def include?(keys, val)
    keys.any? { |key| is?(val, key) }
  end
end
