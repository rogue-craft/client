class Menu::MenuSystem

  include Dependency[:game_state, :interface, :keymap, :event, :color_bag]

  def initialize(args)
    super
    @menu_types = {
      main: Menu::MainMenu,
      registration: Menu::Registration,
      login: Menu::Login
    }
    @instances = {}

    open_main
  end

  state_machine :state, initial: :closed do
    transition all - :main => :main, on: :open_main
    transition all - :registration => :registration, on: :open_registration
    transition all - :login => :login, on: :open_login

    after_transition on: all, do: :create_menu
  end

  def render
    @current_menu.render
  end

  def navigate(input)
    @current_menu.navigate(input)
  end

  def close
    if @game_state.in_menu?
      @instances.each(&:close)
    end
  end

  private
  def create_menu(transition)
    type = transition.to.to_sym

    if @current_menu
      @current_menu.clear
    end

    unless @instances[type]
      @instances[type] = @menu_types[type].new(
          self, @game_state, @keymap,
          @interface, @event, @color_bag
      )
    end

    @current_menu = @instances[type]
  end
end
