require 'eventmachine'
require 'ncursesw'
require 'state_machines'
require 'ostruct'
require 'fileutils'
require 'os'

require 'dry-container'
require 'dry-auto_inject'
require 'dry/events/publisher'


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
require_relative './handler/handler'
require_relative './event/event'
require_relative './client/client'
require_relative './snapshot/snapshot'
require_relative './command/command'

require_relative './keymap'
require_relative './game_state'
require_relative './loop'
require_relative './config'

require_relative './schema/schema'
require_relative './route_map'

class ContainerLoader

  CONFIG_PATH = File.expand_path(__dir__ + '../../../config/config.yml').freeze
  COLOR_SCHEME_PATH = File.expand_path(__dir__ + '../../../config/color_scheme.yml').freeze

  def self.load
    c = Dependency.container

    config = Config.new(CONFIG_PATH)

    c[:config] = -> { config }

    c[:logger] = -> { logger(config) }
    c[:game_state] = -> { GameState.new }
    c[:keymap] = -> { Keymap.new }
    c[:interface] = -> { Display::Interface.new }
    c[:color_scheme] = -> { Display::ColorScheme.new(COLOR_SCHEME_PATH) }

    c[:menu_system] = -> { Menu::MenuSystem.new }

    c[:event] = -> { Event::Publisher.new }

    c[:camera] = -> { OpenStruct.new(y: 0, x: 0, width: Ncurses.COLS, height: Ncurses.LINES) }
    c[:game_loop] = -> { Loop.new }

    c[:session] = -> { Client::Session.new }

    c[:snapshot_storage] = -> { Snapshot::Storage.new }
    c[:interpolator] = -> { Snapshot::Interpolator.new }
    c[:renderer_strategy] = -> { [Display::Renderer::World.new] }
    c[:renderer] = -> { Display::Renderer.new }

    c[:commmand_factories] = -> { [ Command::Factory::DirectionChange.new ] }
    c[:command_queue] = -> { Command::Queue.new }
    c
  end

  def self.logger(cfg)
    FileUtils.mkdir_p(File.dirname(cfg[:log_file]))

    logger = Logger.new(cfg[:log_file])
    logger.level = Logger.const_get(cfg[:log_level].upcase)

    logger
  end

  def self.register_rpc(c)
    cfg = c.resolve(:config)

    c[:default_connection] = -> { Client::ConnectionWrapper.new }
    c[:serializer] = -> { RPC::Serializer.new(c[:logger]) }
    c[:router] = -> { RPC::Router.new(RouteMap.new.load, c[:logger]) }
    c[:async_store] = -> { RPC::AsyncStore.new(cfg[:response_timeout], c[:logger] ) }
    c[:snapshot_handler] = -> { Handler::Snapshot.new }
    c[:message_dispatcher] = -> { RPC::MessageDispatcher.new(c[:serializer], c[:async_store], c[:default_connection]) }
  end
end
