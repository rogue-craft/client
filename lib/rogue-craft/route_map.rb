class RouteMap

  include Dependency[:snapshot_handler]

  def load
    {
      snapshot: {
        handler: @snapshot_handler,
        schema: {
          receive: Schema::Snapshot::Receive.new
        }
      }
    }
  end
end
