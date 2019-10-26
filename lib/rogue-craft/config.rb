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
    cli_opts = {}

    OptionParser.new do |opts|
      opts.on("-e ENV", "--env ENV", "Set alternative env config") {|env| cli_opts[:env] = env }
    end.parse!

    env = cli_opts.fetch(:env, :default).to_sym
    cfg = YAML::load(File.open('./config.yml'))

    @values = cfg[:default]
      .merge(cfg[env])
      .merge(cli_opts)
  end
end
