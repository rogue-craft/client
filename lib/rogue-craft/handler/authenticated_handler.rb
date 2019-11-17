class Handler::AuthenticatedHandler < RPC::InjectedHandler
  include Dependency[:session]

  def get_params(params)
    params.merge({token: @session.token})
  end
end
