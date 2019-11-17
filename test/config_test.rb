require_relative 'test'

class ConfigTest < MiniTest::Test

  def test_server_selection
    cfg = create_cfg
    assert(false == cfg.server_selected?)

    cfg.select_server('localhost:666')
    assert(cfg.server_selected?)
    assert('localhost', cfg[:ip])
    assert('666', cfg[:port])

    cfg.unselect_server
    assert(false == cfg.server_selected?)
    assert_raises(KeyError) { cfg[:ip] }
    assert_raises(KeyError) { cfg[:port] }

    assert_raises(ArgumentError) do
      cfg.select_server('invalid_address')
    end
  end

  private
  def create_cfg
    Config.new(__dir__ + '/fixture/config.yml')
  end
end
