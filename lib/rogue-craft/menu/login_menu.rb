class Menu::Login < Menu::BaseMenu
  private

  def create_title
    'Login'
  end

  def create_items
    input(:nickname, 'Nickname')
    input(:password, 'Password', password: true)

  end
end
