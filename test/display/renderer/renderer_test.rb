require_relative '../../test_case'

class RendererTest < TestCase

  def test_no_snapshot
    history = mock
    history.expects(:relevant).returns(nil)

    strategy_1 = mock
    strategy_1.expects(:render).never

    strategy_2 = mock
    strategy_2.expects(:render).never

    renderer = Display::Renderer.new(snapshot_history: history, renderer_strategy: [strategy_1, strategy_2])
    renderer.render
  end

  def test_renderer
    snapshot = mock

    history = mock
    history.expects(:relevant).returns(snapshot)

    strategy_1 = mock
    strategy_1.expects(:render).with(snapshot)

    strategy_2 = mock
    strategy_2.expects(:render).with(snapshot)

    renderer = Display::Renderer.new(snapshot_history: history, renderer_strategy: [strategy_1, strategy_2])
    renderer.render
  end
end
