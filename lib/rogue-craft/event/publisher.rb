class Event::Publisher
  include Dry::Events::Publisher[:default]

  EVENTS = [
    :registration, :login,
    :camera_movement
  ].freeze

  def initialize
    super
    subscribe_listeners
  end

  private
  def subscribe_listeners
    EVENTS.each(&method(:register_event))

    subscribe(Event::Listener::CameraMovement.new)
    subscribe(Event::Listener::Auth.new)

    RogueCraftCommon.register_common_listeners(self, Dependency.container)
  end
end
