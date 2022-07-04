class GameWindow < Gosu::Window
  include Dependency[:game_state, :menu_system]

  def initialize(**args)
    super(640, 480)

    # @type [GameState]
    @game_state = args[:game_state]
    # @type [Menu::MenuSystem]
    @menu_system = args[:menu_system]
  end

  def update; end

  def button_down(key)
    @menu_system.navigate(key) if @game_state.in_menu?
  end

  def draw
    @menu_system.draw(self) if @game_state.in_menu?
  end
end
