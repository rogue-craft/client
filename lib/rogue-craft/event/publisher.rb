class Event::Publisher
  include Dry::Events::Publisher[:default]

  EVENTS = [
    :registration, :login, :activation, :logout,
    :server_selection, :disconnection
  ].freeze

  def subscribe_listeners
    EVENTS.each(&method(:register_event))

    subscribe(Event::Listener::Auth.new)
    subscribe(Event::Listener::Connection.new)

    RogueCraftCommon.register_common_listeners(self, Dependency.container)
  end
end
