require_relative 'rogue-craft/container_loader'

class RogueCraft
  def run
    container = Dependency.container

    EM.run do
      connection = EM::connect(ENV['IP'], ENV['PORT'], Client::Connection)
      container = ContainerLoader.load(connection)
      game_loop = container.resolve(:game_loop)

      container.resolve(:menu_system).render
      EM.error_handler {|e| game_loop.close(e) }
      EM.add_periodic_timer(0.05) { game_loop.update }
    end
  rescue Interrupt
  end
end
