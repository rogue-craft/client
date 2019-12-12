class Menu::LoggedIn < Menu::BaseMenu

  def navigate(input)
    if @keymap.is?(input, :escape)
      @event.publish(:disconnection)
      return
    end

    super
  end

  private
  def create_items
    item('Join Game', -> () { @event.publish(:join_game) })
    item('Disconnect', -> () { @event.publish(:disconnection) })
    item('Logout', -> () { @event.publish(:logout) })
  end
end
