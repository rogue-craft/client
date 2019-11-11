class Menu::Servers < Menu::BaseMenu

  include Dependency[:config, :session]

  def navigate(input)
    return if @keymap.is?(input, :escape)

    super
  end

  private
  def create_items
    env = @config[:env]

    @config[:servers].map do |name,address|
      next if :local == name && env != :local

      item(name.to_s, proc do
        @config.select_server(address)
        @session.start
        @event.publish(:validate_token)
      end)
    end
  end
end
