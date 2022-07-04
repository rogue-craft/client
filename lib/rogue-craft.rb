require_relative 'rogue-craft/container_loader'

class RogueCraft
  TIMEOUT = 0.05

  def run
    container = ContainerLoader.load
    container.resolve(:event).subscribe_listeners
    game_loop = container.resolve(:game_loop)

    machine_thread = Thread.new do
      EM.run do
        # EM.error_handler {|e| game_loop.close(e) }
        # EM.add_periodic_timer(TIMEOUT) { game_loop.update }
      end
    end

    Ruby2D::Window.update { game_loop.update }
    Ruby2D::Window.set(resizable: true)

    Ruby2D::Window.show

    machine_thread.kill
  rescue Interrupt
    container[:game_loop].close
  end
end
