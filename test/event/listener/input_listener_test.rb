require_relative '../../test_case'

class GameInputListenerTest < TestCase

  def test_on_input
    event = {input: 'w'}

    queue = mock
    queue.expects(:push).with('w')

    listener = Event::Listener::GameInput.new(command_queue: queue)
    listener.on_input(event)
  end

  def test_on_end_of_input
    event = {}

    queue = mock
    queue.expects(:execute)

    listener = Event::Listener::GameInput.new(command_queue: queue)
    listener.on_end_of_input(event)
  end
end
