class Menu::Registration < Menu::BaseMenu

  private
  def create_items
    fields = [
      input(:nickname, "Nickname"),
      input(:email, "Email"),
      input(:password, "Password", password: true),
      input(:password_confirmation, "Password Confirmation", password: true)
    ]

    form(
      fields,
      40,
      proc { |form| @event.publish(:registration, {form: form}) }
    )
  end
end
