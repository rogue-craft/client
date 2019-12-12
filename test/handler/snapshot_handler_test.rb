require_relative '../test_case'

class SnapshotHandlerTest < TestCase

  def test_handler
    snapshot = [:snapshot]
    msg = RPC::Message.from(params: {snapshot: snapshot})

    history = mock
    history.expects(:push).with(snapshot)

    handler = Handler::Snapshot.new(snapshot_history: history)
    handler.receive(msg)
  end
end
