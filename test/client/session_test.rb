require_relative '../test'


class SessionTest < MiniTest::Test

  SESSION_FILE = __dir__ + '/session-127_0_0_1-9000-unittest'

  def teardown
    File.delete(SESSION_FILE) if File.exist?(SESSION_FILE)
  end

  def test_immutable_token
    session = new_session
    session.token = 'initial'

    assert_raises(RuntimeError) do
      session.token = 'other'
    end
  end

  def test_persistance
    session = new_session
    assert(false == File.exist?(SESSION_FILE))

    session.token = "Test1"
    assert_equal("Test1", session.token)
    assert(File.exist?(SESSION_FILE))

    session2 = new_session
    assert_equal("Test1", session2.token)
  end

  def test_clear
    session = new_session

    session.token = "Test1"
    assert_equal("Test1", session.token)
    assert(File.exist?(SESSION_FILE))

    session.clear
    assert(false == File.exist?(SESSION_FILE))
    assert_nil(session.token)
  end

  def test_close
    session = new_session

    session.token = "Test1"
    assert_equal("Test1", session.token)
    assert(File.exist?(SESSION_FILE))

    session.close
    assert(File.exist?(SESSION_FILE))
    assert_nil(session.token)
  end

  def test_logged_in?
    session = new_session
    assert(false == session.logged_in?)

    session.token = 'token_1'
    assert(session.logged_in?)

    session.close
    assert(false == session.logged_in?)

    session.token = 'token_1'
    assert(session.logged_in?)

    session.clear
    assert(false == session.logged_in?)
  end

  private
  def new_session
    Client::Session.new(config: mock_config)
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
