require_relative '../test'

class ColorSchemeTest < MiniTest::Test

  def test_happy_path
    Ncurses.expects(:init_color).with(0, 0, 0, 0)
    Ncurses.expects(:init_color).with(1, 1000, 0, 0)
    Ncurses.expects(:init_pair).with(0, 0, 0)
    Ncurses.expects(:init_pair).with(1, 1, 0)

    scheme = Display::ColorScheme.new(__dir__ + '/fixture/correct_color_scheme.yml')

    assert_equal(0, scheme[:menu][:color_pair])
    assert_equal(1, scheme[:menu_settings][:color_pair])

    err = assert_raises(ArgumentError) do
      scheme[:unknown]
    end

    assert_equal('No such style definition in the colorscheme: unknown', err.message)
  end

  def test_missing_color
    Ncurses.expects(:init_color).with(0, 1000, 0, 0)

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
