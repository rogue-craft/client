require 'yaml'
require 'optparse'

class Config

  def initialize(path)
    @values = {}
    load(path)
  end

  private
  def load(path)
    cli_opts = {}

    OptionParser.new do |opts|
      opts.on("-e ENV", "--env ENV", "Set alternative env config") {|env| cli_opts[:env] = env }
    end.parse!

    @values = YAML::load(File.open('./config.yml'))
      .merge(cfg[cli_opts.fetch(:env, :default)])
      .merge(cli_opts)
  end
end
