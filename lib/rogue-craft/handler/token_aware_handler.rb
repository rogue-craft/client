class Handler::TokenAwareHandler < RPC::InjectedHandler
  include Dependency[:session]

  def get_params(params)
    params.merge({token: @session.token})
  end
end
