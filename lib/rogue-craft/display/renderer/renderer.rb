class Display::Renderer
  include Dependency[:interpolator, :renderer_strategy]

  def render
    return unless snapshot = @interpolator.interpolate

    @renderer_strategy.each { |r| r.render(snapshot) }
  end
end
