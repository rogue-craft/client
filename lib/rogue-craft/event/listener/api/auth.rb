class Event::Listener::Auth < RPC::InjectedHandler

  include Dependency[:session]

  def on_registration(event)
    form = event[:form]

    send_msg(target: 'auth/registration', params: form.data) do |response|
      handle_form(response, form)
    end
  end

  def on_login(event)
    form = event[:form]

    send_msg(target: 'auth/login', params: form.data) do |response|
      if response[:violations]
        form.errors = response[:violations]
      else
        @session.token = response[:token]
        form.success.call
      end
    end
  end

  def on_activation(event)
    form = event[:form]

    send_msg(target: 'auth/activation', params: form.data) do |response|
      handle_form(response, form)
    end
  end

  def on_logout
    send_msg(target: 'auth/logout') { @session.clear }
  end

  private
  def handle_form(response, form)
    if response[:violations] || false == response.code?(RPC::Code::OK)
      form.errors = response.fetch(:violations, {'Unexpected error': 'Please try again later :('})
    else
      form.success.call
    end
  end
end
