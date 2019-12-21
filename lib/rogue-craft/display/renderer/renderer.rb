class Display::Renderer
  include Dependency[:interpolator, :renderer_strategy]

  def render
    return unless snapshot = @interpolator.current

    @renderer_strategy.each { |r| r.render(snapshot) }
  end
end

