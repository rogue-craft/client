class Display::Renderer
  def initialize(strategy)
    @strategy = strategy
  end

  def render
    @strategy.each(&:render)
  end
end

