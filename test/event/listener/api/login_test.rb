require_relative '../../../test'


class LoginTest < MiniTest::Test

  def test_happy_path
    success = mock
    success.expects(:call)

    form = OpenStruct.new(data: 'hello', success: success)
    response = RPC::Message.from(code: RPC::Code::OK, params: {token: 'user-token'})

    session = mock
    session.expects(:token=).with(response[:token])

    run_login_test(form, response, session)
  end

  def test_acces_denied
    form = OpenStruct.new(data: 'hello')
    response = RPC::Message.from(code: RPC::Code::ACCESS_DENIED, params: {violations: {'nickname/password': ['Wrong credentials']}})

    run_login_test(form, response)

    assert_equal(response[:violations], form.errors)
  end

  private
  def run_login_test(form, response, session = nil)
    dispatcher = mock
    dispatcher.expects(:dispatch).yields(response).with do |msg|
      assert_equal('auth/login', msg.target)
      assert_equal(form.data, msg.params)
    end

    event = {form: form}

    listener = Event::Listener::Auth.new(message_dispatcher: dispatcher, session: session)
    listener.on_login(event)
  end
end
