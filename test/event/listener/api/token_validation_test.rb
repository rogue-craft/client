require_relative '../../../test_case'

class TokenValidationTest < TestCase

  def test_valid_token
    menu = mock
    menu.expects(:open_logged_in)

    run_test(RPC::Code::OK, stub_session, menu)
  end

  def test_invalid_token
    session = mock
    session.expects(:token).returns('token123')
    session.expects(:clear)

    menu = mock
    menu.expects(:open_main)

    run_test(RPC::Code::ACCESS_DENIED, session, menu)
  end

  private
  def run_test(response_code, session, menu_system)
    response = RPC::Message.from(code: response_code)

    dispatcher = mock
    dispatcher.expects(:dispatch).yields(response).with do |msg|
      assert_equal('meta/validate_token', msg.target)
    end

    listener = Event::Listener::Meta.new(message_dispatcher: dispatcher, session: session, menu_system: menu_system)
    assert(listener.is_a?(Handler::TokenAwareHandler))

    listener.on_validate_token({})
  end
end
