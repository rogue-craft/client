class Menu::MainMenu < Menu::BaseMenu
  private

  def create_items
    item('Login', submit: @system.method(:open_login))
    item('Registration', submit: @system.method(:open_registration))
    item('Account Activation', submit: @system.method(:open_activation))
    item('Disconnect', submit: -> { @event.publish(:disconnection) })
  end
end
