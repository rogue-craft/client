require 'yaml'
require 'optparse'

class Config

  def initialize(path)
    @values = {}
    load(path)
  end

  def [](key)
    value = @values[key]

    raise KeyError.new("Unknown config key #{key}") unless value

    value
  end

  def select_server(server)
    ip, port = server.split(':')

    raise ArgumentError.new("Invalid server address: #{server}") unless ip && port

    @values[:ip] = ip
    @values[:port] = port
  end

  def unselect_server
    @values[:ip] = nil
    @values[:port] = nil
  end

  def server_selected?
    (!@values[:ip].nil? && !@values[:port].nil?)
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
    cfg = YAML.load(File.open(path))

    @values = cfg[:default]
      .merge(cfg.fetch(env, {}))
      .merge(cli_opts)

    @values[:cache_dir] = @values[:cache_dir][OS.posix? ? :nix : :windows]
  end
end
