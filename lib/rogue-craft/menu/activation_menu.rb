class Menu::Activation < Menu::BaseMenu

  private
  def create_items
    fields = [
      input(:activation_code, "Activation Code"),
    ]

    form(
      fields,
      40,
      proc { |form| @event.publish(:activation, {form: form}) }
    )
  end
end
