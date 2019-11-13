class Menu::MainMenu < Menu::BaseMenu

  private
  def create_items
    item('Login', @system.method(:open_login))
    item('Registration', @system.method(:open_registration))
    item('Account Activation', @system.method(:open_activation))
    item('Disconnect', -> () { @event.publish(:disconnection) } )
  end
end
