class Menu::Servers < Menu::BaseMenu

  include Dependency[:config, :session]

  def navigate(input)
    return if @keymap.is?(input, :escape)

    super
  end

  private
  def create_items
    env = @config[:env]

    @config[:servers].each do |name, address|
      next if :local == name && env != :local

      item(name.to_s, proc do
        @session.start
        @event.publish(:server_selection, {server: address})
      end)
    end
  end
end
