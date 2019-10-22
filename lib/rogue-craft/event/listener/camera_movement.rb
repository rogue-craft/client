class Event::Listener::CameraMovement

  include Dependency[:camera]

  def on_camera_movement(event)
    # raise ArgumentError.new("Key: ": + event[:key])

  end
end
