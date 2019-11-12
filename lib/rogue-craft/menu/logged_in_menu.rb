class Menu::LoggedIn < Menu::BaseMenu

  private
  def create_items
    item('Join Game')
    item('Logout', -> () { @event.publish(:logout) })
  end
end
