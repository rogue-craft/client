class Event::Listener::Auth < RPC::InjectedHandler

  include Dependency[:session]

  def on_registration(event)
    form = event[:form]

    send_msg(target: 'auth/registration', params: form.data) do |response|
      if response[:violations]
        form.errors = response[:violations]
      else
        form.success.call
      end
    end
  end

  def on_login(event)
    form = event[:form]

    send_msg(target: 'auth/login', params: form.data) do |response|
      if response[:violations]
        form.errors = response[:violations]
      else
        @session.token = response[:token]
      end
    end
  end

  def on_logout
    send_msg(target: 'auth/logout')

    @session.clear
  end
end
