class Event::Listener::GameInput
  include Dependency[:command_queue]

  def on_input(event)
    @command_queue.push(event[:input])
  end

  def on_end_of_input(_)
    @command_queue.execute
  end
end
