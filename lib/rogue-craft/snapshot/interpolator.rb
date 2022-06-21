class Snapshot::Interpolator

  include Dependency[:snapshot_storage]

  def interpolate
    original = @snapshot_storage.current

    return original

    # return unless original

    snapshot = duplicate(original)
    timestamp = snapshot[:timestamp]

    snapshot[:entities].map! do |entity|
      interpolate_movement(entity, timestamp)
    end
    snapshot[:player] = interpolate_movement(snapshot[:player], timestamp)

    snapshot
  end

  private
  def interpolate_movement(entity, timestamp)
    return entity unless movement = entity[:movement]

    _, _, x, y = Interpolation.position(
      entity[:x], entity[:y], movement[:speed], movement[:direction], timestamp
    )

    entity[:x] = x unless x.nil?
    entity[:y] = y unless y.nil?

    entity
  end

  def duplicate(snapshot)
    Marshal.load(Marshal.dump(snapshot))
  end
end
