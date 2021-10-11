class Command::Queue < Handler::AuthenticatedHandler

  include Dependency[:commmand_factories]

  def initialize(**args)
    super
    @queue = []
  end

  def push(input)
    @commmand_factories.each do |factory|
      if factory.supports?(input)
        @queue << factory.create(input)
        break
      end
    end
  end

  def execute
    unless @queue.empty?
      send_msg(target: 'command/execute', params: {queue: @queue})
      @queue = []
    end
  end
end
