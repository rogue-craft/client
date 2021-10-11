class Client::Session

  include Dependency[:config]

  def initialize(**args)
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

  def logged_in?
    nil != @values[:token]
  end

  def clear
    close
    path = store_path

    File.delete(path) if File.exist?(path)
  end

  def start
    path = store_path

    return unless path && File.exist?(path)

    @values = MessagePack.unpack(File.binread(path))
  end

  def close
    @values = {}
  end

  private
  def dump
    File.open(store_path, 'w+') do |f|
      f.write(MessagePack.pack(@values))
    end
  end

  def store_path
    return nil unless @config.server_selected?

    file = "session-%s-%d-%s" % [@config[:ip].gsub('.', '_'), @config[:port], @config[:env].to_s]

    File.join(@config[:cache_dir], file)
  end
end
