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

  # @param window [Window]
  #
  def draw(window)
    @current_menu.draw(window)
  end

  def navigate(input)
    @current_menu.navigate(input)
  end

  private

  def open_menu(type)
    unless @instances[type]
      @instances[type] = @menu_types[type].new(
        self, @game_state, @keymap,
        @event, @color_scheme
      )
    end

    @current_menu = @instances[type]
  end
end
