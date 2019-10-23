class Client::Session
  attr_reader :token

  def initialize(store_dir)
    @store_path = "#{store_dir}/session"
    @token = nil
    load
  end

  def token=(token)
    raise RuntimeError.new('Session.token already set') if @token

    @token = token
    dump
  end

  def clear
    @token = nil

    File.delete(@store_path) if File.exist?(@store_path)
  end

  private
  def load
    return unless File.exist?(@store_path)

    values = MessagePack.unpack(File.binread(@store_path))
    @token = values['token']
  end

  def dump
    File.open(@store_path, 'w+') do |f|
      f.write(MessagePack.pack({'token' => @token}))
    end
  end
end
