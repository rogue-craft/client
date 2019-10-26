class Menu::Servers < Menu::BaseMenu

  include Dependency[:config]

  private
  def create_items
    @config[:servers].map do |name,address|
      item(name.to_s, proc do
        @config.select_server(address)
        @system.open_main
      end)
    end
  end
end
