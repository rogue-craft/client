class Menu::LoggedIn < Menu::BaseMenu

  private
  def create_items
    item('Join Game')
    item('Disconnect', -> () { @event.publish(:disconnection) })
    item('Logout', -> () { @event.publish(:logout) })
  end
end
