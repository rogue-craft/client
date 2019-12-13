require_relative '../test'

class ColorSchemeTest < MiniTest::Test

  def test_happy_path
    Ncurses.expects(:init_color).with(1, 0, 0, 0)
    Ncurses.expects(:init_color).with(2, 1000, 0, 0)

    Ncurses.expects(:init_pair).with(1, 1, 1)
    Ncurses.expects(:COLOR_PAIR).with(1).returns(10)
    Ncurses.expects(:init_pair).with(2, 2, -1)
    Ncurses.expects(:COLOR_PAIR).with(2).returns(20)

    scheme = Display::ColorScheme.new(__dir__ + '/fixture/correct_color_scheme.yml')

    assert_equal(10, scheme[:menu][:color_pair])
    assert_equal(20, scheme[:menu_settings][:color_pair])
  end

  def test_missing_color
    Ncurses.expects(:init_color).with(1, 1000, 0, 0)

    err = assert_raises(ArgumentError) do
      Display::ColorScheme.new(__dir__ + '/fixture/missing_color_scheme.yml')
    end

    assert_equal('No such color defined: black', err.message)
  end

  def test_missing_rgb_elem
    Ncurses.expects(:init_color).never

    err = assert_raises(ArgumentError) do
      Display::ColorScheme.new(__dir__ + '/fixture/missing_rgb_elem_scheme.yml')
    end

    assert_equal('Invalid RGB. It must be an array with three integers between 0 and 255. [255] given', err.message)
  end

  def test_out_of_range_rgb
    Ncurses.expects(:init_color).never

    err = assert_raises(ArgumentError) do
      Display::ColorScheme.new(__dir__ + '/fixture/out_of_range_rgb_scheme.yml')
    end

    assert_equal('Invalid RGB. It must be an array with three integers between 0 and 255. [1000, 0, 0] given', err.message)
  end
end
