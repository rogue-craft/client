class RouteMap

  include Dependency[:world_handler]

  def load
    {
      world: {
        handler: @world_handler,
        schema: {
          snapshot_stream: Schema::World::Snapshot.new
        }
      }
    }
  end
end
