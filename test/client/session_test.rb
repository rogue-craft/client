require_relative '../test'


class SessionTest < MiniTest::Test

  SESSION_FILE = __dir__ + '/session-127_0_0_1-9000-unittest'

  def teardown
    File.delete(SESSION_FILE) if File.exist?(SESSION_FILE)
  end

  def test_immutable_token
    session = new_serializer
    session.token = 'initial'

    assert_raises(RuntimeError) do
      session.token = 'other'
    end
  end

  def test_persistance
    session = new_serializer
    assert(false == File.exist?(SESSION_FILE))

    session.token = "Test1"
    assert_equal("Test1", session.token)
    assert(File.exist?(SESSION_FILE))

    session2 = new_serializer
    assert_equal("Test1", session2.token)
  end

  def test_clear
    session = new_serializer

    session.token = "Test1"
    assert_equal("Test1", session.token)
    assert(File.exist?(SESSION_FILE))

    session.clear
    assert(false == File.exist?(SESSION_FILE))
    assert_nil(session.token)
  end

  private
  def new_serializer
    Client::Session.new(config: mock_config, serializer: RPC::Serializer.new(mock))
  end

  def mock_config
    cfg = {
      cache_dir: __dir__,
      ip: '127.0.0.1',
      port: 9000,
      env: 'unittest'
    }

    def cfg.server_selected?; true end

    cfg
  end
end
