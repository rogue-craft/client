require_relative 'rogue-craft/container_loader'

class RogueCraft
  TIMEOUT = 0.05.freeze

  def run
    container = ContainerLoader.load

    menu_system = container.resolve(:menu_system)
    config = container.resolve(:config)
    game_loop = container.resolve(:game_loop)
    publisher = container.resolve(:event)

    until config.server_selected?
      menu_system.render
      game_loop.update
      sleep(TIMEOUT)
    end

    EM.run do
      connection = EM::connect(config[:ip], config[:port], Client::Connection)

      ContainerLoader.register_rpc(container, connection)
      publisher.subscribe_listeners

      intial_token_valitaion(publisher, menu_system)

      EM.error_handler {|e| game_loop.close(e) }
      EM.add_periodic_timer(TIMEOUT) { game_loop.update }
    end
  rescue Interrupt
  end

  private
  def intial_token_valitaion(publisher, menu_system)
    publisher.publish(:validate_token, {
      valid: menu_system.method(:open_logged_in),
      invalid: menu_system.method(:open_main)
    })
  end
end
