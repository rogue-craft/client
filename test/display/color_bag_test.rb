require_relative '../test'


class ColorBagTest < MiniTest::Test

  def test_bag
    bag = Display::ColorBag.new
    pair_id = 1
    Ncurses.expects(:init_pair).once.with(pair_id, Ncurses::COLOR_RED, Display::ColorBag::COLOR_NONE)

    color_value = 99
    Ncurses.expects(:COLOR_PAIR).times(2).with(pair_id).returns(color_value)

    red_1 = bag.get(fg: Ncurses::COLOR_RED, bg: Display::ColorBag::COLOR_NONE)
    assert(red_1.is_a?(Integer))
    assert_equal(red_1, color_value)

    red_2 = bag.get(fg: Ncurses::COLOR_RED, bg: Display::ColorBag::COLOR_NONE)
    assert(red_1.is_a?(Integer))
    assert_equal(red_1, color_value)

    assert_equal(red_1, red_2)
  end
end
