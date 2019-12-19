class Display::Renderer
  include Dependency[:snapshot_storage, :renderer_strategy]

  def render
    return unless snapshot = @snapshot_storage.current

    @renderer_strategy.each { |r| r.render(snapshot) }
  end
end

