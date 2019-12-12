class Handler::World < Handler::AuthenticatedHandler

  include Dependency[:snapshot_history]

  def snapshot_stream(msg)
    @snapshot_history.push(msg[:snapshot])
    nil
  end
end
