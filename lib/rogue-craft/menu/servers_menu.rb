class Menu::Servers < Menu::BaseMenu
  include Dependency[:config]

  def navigate(input)
    return if @keymap.is?(input, :escape)

    super
  end

  private

  def create_items
    env = @config[:env]

    @config[:servers].each do |name, server|
      next if name == :development && env != :development

      field(
        name.to_s,
        submit: -> { @event.publish(:server_selection, {server: server[:host]}) },
        hint: server[:hint]
      )
    end

    line

    field('Exit')
  end

  def create_title
    'Join Game'
  end
end
