class Handler::Snapshot < Handler::AuthenticatedHandler

  include Dependency[:snapshot_history]

  def stream(msg)
    @snapshot_history.push(msg.params)
    nil
  end
end
