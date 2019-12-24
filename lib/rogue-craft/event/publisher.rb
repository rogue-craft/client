class Event::Publisher
  include Dry::Events::Publisher[:default]

  EVENTS = [
    :registration, :login, :activation, :logout,
    :server_selection, :check_token, :disconnection, :join_game,
    :input, :end_of_input
  ].freeze

  def subscribe_listeners
    EVENTS.each(&method(:register_event))

    subscribe(Event::Listener::Auth.new)
    subscribe(Event::Listener::Connection.new)
    subscribe(Event::Listener::Join.new)
    subscribe(Event::Listener::GameInput.new)

    RogueCraftCommon.register_common_listeners(self, Dependency.container)
  end
end
