class Event::Publisher
  include Dry::Events::Publisher[:default]

  EVENTS = [
    :registration, :login, :activation,
    :validate_token,
    :camera_movement
  ].freeze

  def subscribe_listeners
    EVENTS.each(&method(:register_event))

    subscribe(Event::Listener::CameraMovement.new)
    subscribe(Event::Listener::Auth.new)
    subscribe(Event::Listener::Meta.new)

    RogueCraftCommon.register_common_listeners(self, Dependency.container)
  end
end
