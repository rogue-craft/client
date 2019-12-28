require_relative '../test_case'

class TestHandler < Handler::AuthenticatedHandler

  def test
    send_msg
  end
end

class AuthenticatedHandlerTest < TestCase

  def test_handler
    session = mock_session

    dispatcher = mock
    dispatcher.expects(:dispatch).with do |msg|
      assert_equal(session.token, msg[:token])
    end

    TestHandler.new(message_dispatcher: dispatcher, session: session).test
  end
end
