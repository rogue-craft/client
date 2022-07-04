class Keymap
  TAB = 9

  def initialize
    @keys = {
      menu_up: [Gosu::KB_UP],
      menu_down: [Gosu::KB_DOWN],
      menu_right: [Ncurses::KEY_RIGHT],
      menu_left: [Ncurses::KEY_LEFT],
      start_of_line: [Ncurses::KEY_HOME],
      end_of_line: [360, Ncurses::KEY_END],
      up: ['w'.ord],
      left: ['a'.ord],
      down: ['s'.ord],
      right: ['d'.ord],
      submit: [Gosu::KB_ENTER, Gosu::KB_RETURN],
      backspace: [Ncurses::KEY_BACKSPACE],
      delete: [Ncurses::KEY_DC],
      escape: [Gosu::KB_ESCAPE]
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
