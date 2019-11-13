require_relative '../../../test'


class ActivationTest < MiniTest::Test

  def test_happy_path
    response = RPC::Message.from

    dispatcher = mock
    dispatcher.expects(:dispatch).yields(response).with do |msg|
      assert_equal('auth/activation', msg.target)
      assert_equal('code123', msg[:activation_code])
    end

    menu = mock
    menu.expects(:open_login).once

    form = mock
    form.expects(:data).once.returns({activation_code: 'code123'})

    listener = Event::Listener::Auth.new(message_dispatcher: dispatcher, session: mock, menu_system: menu)
    listener.on_activation({activation_code: 'code123', form: form})
  end
end
