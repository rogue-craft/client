require_relative '../../test_case'

class RendererTest < TestCase

  def test_no_snapshot
    storage = mock
    storage.expects(:current).returns(nil)

    strategy_1 = mock
    strategy_1.expects(:render).never

    strategy_2 = mock
    strategy_2.expects(:render).never

    renderer = Display::Renderer.new(snapshot_storage: storage, renderer_strategy: [strategy_1, strategy_2])
    renderer.render
  end

  def test_renderer
    snapshot = mock

    storage = mock
    storage.expects(:current).returns(snapshot)

    strategy_1 = mock
    strategy_1.expects(:render).with(snapshot)

    strategy_2 = mock
    strategy_2.expects(:render).with(snapshot)

    renderer = Display::Renderer.new(snapshot_storage: storage, renderer_strategy: [strategy_1, strategy_2])
    renderer.render
  end
end
