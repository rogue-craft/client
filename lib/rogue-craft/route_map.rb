class RouteMap

  include Dependency[:snapshot_handler]

  def load
    {
      snapshot: {
        handler: @snapshot_handler,
        schema: {
          stream: Schema::Snapshot::Stream.new
        }
      }
    }
  end
end
