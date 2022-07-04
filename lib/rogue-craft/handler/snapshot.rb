class Handler::Snapshot < Handler::AuthenticatedHandler
  include Dependency[:snapshot_storage]

  def stream(msg)
    @snapshot_storage.add(msg.params[:snapshot])
    nil
  end
end
