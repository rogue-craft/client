class Keymap

  TAB = 9

  def initialize
    @keys = {
      menu_up: [Ncurses::KEY_BTAB],
      menu_down: [TAB],
      menu_right: [Ncurses::KEY_RIGHT],
      menu_left: [Ncurses::KEY_LEFT],
      start_of_line: [Ncurses::KEY_HOME],
      end_of_line: [360, Ncurses::KEY_END],
      up: ['w'.ord],
      left: ['a'.ord],
      down: ['s'.ord],
      right: ['d'.ord],
      submit: [10, Ncurses::KEY_ENTER],
      backspace: [Ncurses::KEY_BACKSPACE],
      delete: [Ncurses::KEY_DC],
      escape: [Ncurses::KEY_F2]
    }.freeze
  end

  def is?(val, key)
    @keys[key]&.include?(val)
  end

  def camera_keys
    @keys.values_at(:up, :left, :down, :right)
  end
end
