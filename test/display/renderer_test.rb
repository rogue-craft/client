require_relative '../test_case'

class RendererTest < TestCase
  def test_renderer
    strategy_1 = mock
    strategy_1.expects(:render)

    strategy_2 = mock
    strategy_2.expects(:render)

    renderer = Display::Renderer.new([strategy_1, strategy_2])
    renderer.render
  end
end
