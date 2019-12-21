class Snapshot::Interpolator

  include Dependency[:snapshot_storage]

  def interpolate
    original = @snapshot_storage.current

    return unless original

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

    x, y = Interpolation.position(
      entity[:x], entity[:y], movement[:speed], movement[:direction], timestamp
    )
    entity[:x] = x
    entity[:y] = y

    entity
  end

  def duplicate(snapshot)
    Marshal.load(Marshal.dump(snapshot))
  end
end
