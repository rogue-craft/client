require_relative '../test_case'

class TestHandler < Handler::TokenAwareHandler

  def test
    send_msg
  end
end

class TokenAwareHandlerTest < TestCase

  def test_handler
    session = mock_session
    response = RPC::Message.from

    dispatcher = mock
    dispatcher.expects(:dispatch).yields(response).with do |msg|
      assert_equal(session.token, msg[:token])
    end

    TestHandler.new(message_dispatcher: dispatcher, session: session).test
  end
end
