require_relative '../../../test_case'

class TokenValidationTest < TestCase

  def test_valid_token
    run_test(:valid, RPC::Code::OK)
  end

  def test_invalid_token
    run_test(:invalid, RPC::Code::ACCESS_DENIED)
  end

  private
  def run_test(type, response_code)
    response = RPC::Message.from(code: response_code)

    dispatcher = mock
    dispatcher.expects(:dispatch).yields(response).with do |msg|
      assert_equal('meta/validate_token', msg.target)
    end

    callback = mock
    callback.expects(:call).once

    listener = Event::Listener::Meta.new(message_dispatcher: dispatcher, session: mock_session)
    assert(listener.is_a?(Handler::TokenAwareHandler))

    listener.on_validate_token({type => callback})
  end
end
