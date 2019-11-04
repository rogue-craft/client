require 'yaml'
require 'optparse'

class Config

  def initialize(path)
    @values = {}
    load(path)
  end

  def [](key)
    value = @values[key]

    raise ArgumentError.new("Unknown config key #{key}") unless value

    value
  end

  def select_server(server)
    ip, port = server.split(':')

    raise ArgumentError.new("Invalid server address #{server}") unless ip || port

    @values[:ip] = ip
    @values[:port] = port
  end

  def server_selected?
    (!!@values[:ip] && !!@values[:port])
  end

  private
  def load(path)
    cli_opts = {
      env: :default
    }

    OptionParser.new do |opts|
      opts.on("-e ENV", "--env ENV", "Set alternative env config") do |env|
        cli_opts[:env] = env.to_sym
      end
    end.parse!

    env = cli_opts.fetch(:env, :default).to_sym
    cfg = YAML::load(File.open(path))

    @values = cfg[:default]
      .merge(cfg.fetch(env, {}))
      .merge(cli_opts)
      .map do |key, val|
        :cache_dir == key ? value[OS.posix? ? :nix : :windows] : value
      end
  end
end
