class Menu::Login < Menu::BaseMenu

  private
  def create_items
    fields = [
      input(:nickname, "Nickname"),
      input(:password, "Password", password: true)
    ]

    form(
      fields,
      40,
      proc { |form| @event.publish(:login, {form: form}) }
    )
  end
end
