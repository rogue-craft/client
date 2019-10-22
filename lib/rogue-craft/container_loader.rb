require 'eventmachine'
require 'ncursesw'
require 'state_machines'
require 'ostruct'
require 'dotenv'

require 'dry-container'
require 'dry-auto_inject'
require 'dry/events/publisher'


Dotenv.load


class Container < Dry::Container

  def register(name, val, opts = {}, &block)
    opts.merge!(memoize: true)
    super
  end

  def []=(name, val)
    register(name, val)
  end
end

Dependency = Dry::AutoInject(Container.new)


require 'rogue-craft-common'

require_relative './menu/menu'
require_relative './display/display'
require_relative './event/event'
require_relative './client/client'

require_relative './keymap'
require_relative './game_state'
require_relative './loop'

require_relative './route_map'

class ContainerLoader

  def self.load(default_connection)
    c = Dependency.container

    c[:logger] = -> { logger }
    c[:game_state] = -> { GameState.new }
    c[:keymap] = -> { Keymap.new }
    c[:interface] = -> { Display::Interface.new }
    c[:color_bag] = -> { Display::ColorBag.new }

    c[:menu_system] = -> { Menu::MenuSystem.new }

    c[:event] = -> { Event::Publisher.new }

    c[:camera] = -> { OpenStruct.new(y: 0, x: 0, width: Ncurses.COLS, height: Ncurses.LINES) }
    c[:renderer] = -> { Display::Renderer.new }
    c[:game_loop] = -> { Loop.new }

    c[:connection] = -> { Client::Connection.new }
    c[:session] = -> { Client::Session.new(ENV['CACHE_DIR']) }

    register_rpc(c, default_connection)

    c
  end

  def self.logger
    logger = Logger.new(ENV['LOG_FILE'])
    logger.level = Logger.const_get(ENV['LOG_LEVEL'].upcase)

    logger
  end

  def self.register_rpc(c, default_connection)
    c[:default_connection] = -> { default_connection }
    c[:serializer] = -> { RPC::Serializer.new(c[:logger]) }
    c[:router] = -> { RPC::Router.new(RouteMap.new, c[:logger]) }
    c[:async_store] = -> { RPC::AsyncStore.new(ENV['RESPONSE_TIMEOUT'], c[:logger] ) }
    c[:message_dispatcher] = -> { RPC::MessageDispatcher.new(c[:serializer], c[:async_store], c[:default_connection]) }
  end
end
