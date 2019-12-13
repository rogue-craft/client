require_relative '../../test_case'

class WorldRendererTest < TestCase

  def test_happy_path
    snapshot = {
      player: {
        y: 100,
        x: 80,
        type: :player
      },
      entities: [
        {
          y: 98,
          x: 84,
          type: :tree
        }
      ]
    }

    window = mock
    window.expects(:getmaxx).returns(20)
    window.expects(:getmaxy).returns(10)
    window.expects(:attron).with(11)
    window.expects(:mvprintw).with(5, 10, '@')
    window.expects(:attroff).with(11)
    window.expects(:mvprintw).with(3, 14, '*')
    window.expects(:refresh)

    interface = mock
    interface.expects(:world_window).returns(window)

    color_scheme = mock
    color_scheme.expects(:[]).with(:player).returns({char: '@', color_pair: 11})
    color_scheme.expects(:[]).with(:tree).returns(nil)

    render = Display::Renderer::World.new(interface: interface, color_scheme: color_scheme)
    render.render(snapshot)
  end
end
