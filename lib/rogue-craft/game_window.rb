class GameWindow < Gosu::Window
  include Dependency[:game_state, :menu_system]

  def initialize(**args)
    super(800, 600)

    # @type [GameState]
    @game_state = args[:game_state]
    # @type [Menu::MenuSystem]
    @menu_system = args[:menu_system]
    @menu_system.window = self

    self.text_input = Gosu::TextInput.new
  end

  def update
  end

  def button_down(key)
    @menu_system.navigate(key) if @game_state.in_menu?
  end

  def draw
    @menu_system.draw(text_input.text) if @game_state.in_menu?
  end
end
