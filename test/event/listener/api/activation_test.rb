require_relative '../../../test'


class ActivationTest < MiniTest::Test

  def test_happy_path
    dispatcher = mock
    dispatcher.expects(:dispatch).with do |msg|
      assert_equal('auth/activation', msg.target)
      assert_equal('code123', msg[:activation_code])
    end

    listener = Event::Listener::Auth.new(message_dispatcher: dispatcher, session: mock)
    listener.on_activation({activation_code: 'code123'})
  end
end
