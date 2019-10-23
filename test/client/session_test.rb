require_relative '../test'


class SessionTest < MiniTest::Test

  SESSION_FILE = __dir__ + '/session'

  def teardown
    File.delete(SESSION_FILE) if File.exist?(SESSION_FILE)
  end

  def test_immutable_token
    session = Client::Session.new(__dir__)
    session.token = 'initial'

    assert_raises(RuntimeError) do
      session.token = 'other'
    end
  end

  def test_persistance
    session = Client::Session.new(__dir__)
    assert(false == File.exist?(SESSION_FILE))

    session.token = "Test1"
    assert_equal("Test1", session.token)
    assert(File.exist?(SESSION_FILE))

    session2 = Client::Session.new(__dir__)
    assert_equal("Test1", session2.token)
  end

  def test_clear
    session = Client::Session.new(__dir__)

    session.token = "Test1"
    assert_equal("Test1", session.token)
    assert(File.exist?(SESSION_FILE))

    session.clear
    assert(false == File.exist?(SESSION_FILE))
    assert_nil(session.token)
  end
end
