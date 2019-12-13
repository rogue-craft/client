class Display::Renderer
  include Dependency[:snapshot_history, :renderer_strategy]

  def render
    return unless snapshot = @snapshot_history.relevant

    @renderer_strategy.each { |r| r.render(snapshot) }
  end
end

