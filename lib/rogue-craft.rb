require_relative 'rogue-craft/container_loader'

class RogueCraft
  TIMEOUT = 0.05

  def run
    container = ContainerLoader.load
    container.resolve(:event).subscribe_listeners

    machine_thread = Thread.new do
      EM.run do
        # EM.error_handler {|e| game_loop.close(e) }
        # EM.add_periodic_timer(TIMEOUT) { game_loop.update }
      end
    end

    GameWindow.new.show

    machine_thread.kill
  end
end
