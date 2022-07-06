class Menu::MainMenu < Menu::BaseMenu
  private

  def create_items
    field('Login', submit: @system.method(:open_login))
    field('Registration', submit: @system.method(:open_registration))
    field('Account Activation', submit: @system.method(:open_activation))
    field('Disconnect', submit: -> { @event.publish(:disconnection) })
  end
end
