class Handler::Snapshot < Handler::AuthenticatedHandler

  include Dependency[:snapshot_history]

  def receive(msg)
    @snapshot_history.push(msg[:snapshot])
  end
end
