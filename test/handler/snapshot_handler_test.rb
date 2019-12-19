require_relative '../test_case'

class SnapshotHandlerTest < TestCase

  def test_handler
    snapshot = [:snapshot]
    msg = RPC::Message.from(params: {snapshot: snapshot})

    storage = mock
    storage.expects(:add).with(msg.params)

    handler = Handler::Snapshot.new(snapshot_storage: storage)
    handler.stream(msg)
  end
end
