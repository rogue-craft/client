require_relative '../test_case'

class SnapshotHandlerTest < TestCase

  def test_handler
    snapshot = [:snapshot]
    msg = RPC::Message.from(params: {snapshot: snapshot})

    history = mock
    history.expects(:push).with(snapshot)

    handler = Handler::World.new(snapshot_history: history)
    handler.snapshot_stream(msg)
  end
end
