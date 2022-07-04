class Menu::MenuSystem
  include Dependency[:game_state, :keymap, :event, :color_scheme]

  def initialize(**args)
    @menu_types = {
      servers: Menu::Servers,
      main: Menu::MainMenu,
      registration: Menu::Registration,
      activation: Menu::Activation,
      login: Menu::Login,
      logged_in: Menu::LoggedIn
    }
    @instances = {}

    super

    open_menu(:servers)
  end

  def open_servers
    open_menu(:servers)
  end

  def open_main
    open_menu(:main)
  end

  def open_registration
    open_menu(:registration)
  end

  def open_activation
    open_menu(:activation)
  end

  def open_login
    open_menu(:login)
  end

  def open_logged_in
    open_menu(:logged_in)
  end

  def update
    @current_menu.update
  end

  def navigate(input)
    @current_menu.navigate(input)
  end

  def close
    @instances.values.each(&:close) if @game_state.in_menu?
  end

  def clear
    # @interface.clear
    @current_menu&.clear
  end

  private

  def open_menu(type)
    # clear
    Ruby2D::Window.clear

    @current_menu&.close

    unless @instances[type]
      @instances[type] = @menu_types[type].new(
        self, @game_state, @keymap,
        @event, @color_scheme
      )
    end

    @current_menu = @instances[type]
  end
end
