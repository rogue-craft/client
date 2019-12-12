class Menu::MenuSystem

  include Dependency[:game_state, :interface, :keymap, :event, :color_scheme]

  def initialize(args)
    super
    @menu_types = {
      servers: Menu::Servers,
      main: Menu::MainMenu,
      registration: Menu::Registration,
      activation: Menu::Activation,
      login: Menu::Login,
      logged_in: Menu::LoggedIn
    }
    @instances = {}

    open_servers
  end

  state_machine :state, initial: :closed do
    transition all - :servers => :servers, on: :open_servers
    transition all - :main => :main, on: :open_main
    transition all - :registration => :registration, on: :open_registration
    transition all - :activation => :activation, on: :open_activation
    transition all - :login => :login, on: :open_login
    transition all - :logged_in => :logged_in, on: :open_logged_in

    after_transition on: all, do: :open_menu
  end

  def render
    @current_menu.render
  end

  def navigate(input)
    @current_menu.navigate(input)
  end

  def close
    if @game_state.in_menu?
      @instances.values.each(&:close)
    end
  end

  def clear
    if @current_menu
      @interface.clear
      @current_menu.clear
    end
  end

  private
  def open_menu(transition)
    type = transition.to.to_sym
    clear

    unless @instances[type]
      @instances[type] = @menu_types[type].new(
          self, @game_state, @keymap,
          @interface, @event, @color_scheme
      )
    end

    @current_menu = @instances[type]
  end
end
