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
    item('Join Game', submit: -> { @event.publish(:join_game) })
    item('Disconnect', submit: -> { @event.publish(:disconnection) })
    item('Logout', submit: -> { @event.publish(:logout) })
  end
end
