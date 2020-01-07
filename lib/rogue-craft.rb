require_relative 'rogue-craft/container_loader'

class RogueCraft
  TIMEOUT = 0.05.freeze

  def run
    container = ContainerLoader.load
    container.resolve(:event).subscribe_listeners
    game_loop = container.resolve(:game_loop)

    EM.run do
      EM.error_handler {|e| game_loop.close(e) }
      EM.add_periodic_timer(TIMEOUT) { game_loop.update }
    end
  rescue Interrupt
    container[:game_loop].close
  end
end
