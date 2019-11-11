class Client::Session

  include Dependency[:config, :serializer]

  def initialize(args)
    super

    @values = {}

    start
  end

  def token
    @values[:token]
  end

  def token=(token)
    raise RuntimeError.new('Session.token is already set') if @values[:token]

    @values[:token] = token
    dump
  end

  def clear
    @values = {}
    path = store_path

    File.delete(path) if File.exist?(path)
  end

  private
  def start
    path = store_path

    return unless File.exist?(path)

    @values = @serializer.unserialize(File.binread(path))
  end

  def dump
    File.open(store_path, 'w+') do |f|
      f.write(@serializer.serialize(@values))
    end
  end

  def store_path
    return nil unless @config.server_selected?

    file = "session-%s-%d-%s" % [@config[:ip].gsub('.', '_'), @config[:port], @config[:env].to_s]

    File.join(@config[:cache_dir], file)
  end
end
