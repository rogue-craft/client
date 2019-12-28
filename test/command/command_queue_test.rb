require_relative '../test_case'

class CommandQueueTest < TestCase

  def test_queue
    w_factory = mock
    w_factory.expects(:supports?).with('w').returns(true)
    w_factory.expects(:create).with('w').returns(:command_w)

    w_factory.expects(:supports?).with('m').returns(false)
    w_factory.expects(:supports?).with('r').returns(false)

    r_factory = mock
    r_factory.expects(:supports?).with('r').returns(true)
    r_factory.expects(:create).with('r').returns(:command_r)

    r_factory.expects(:supports?).with('m').returns(false)

    dispatcher = mock
    dispatcher.expects(:dispatch).with do |msg, conn|
      assert([:command_w, :command_r], msg[:queue])
      assert('command/execute', msg.target)
      assert_nil(conn)
    end

    queue = Command::Queue.new(
      commmand_factories: [w_factory, r_factory],
      session: OpenStruct.new(token: 'token123'),
      message_dispatcher: dispatcher
    )

    assert(queue.is_a?(Handler::AuthenticatedHandler))

    queue.push('w')
    queue.push('m')
    queue.push('r')

    queue.execute
  end
end
