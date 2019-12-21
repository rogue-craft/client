require_relative '../test_case'

class InterpolatorTest < TestCase

  def test_movement
    Interpolation
      .expects(:position)
      .with(100, 100, 0.1, Interpolation::Direction::NORTH, 987)
      .returns([98, 101])

    Interpolation
      .expects(:position)
      .with(200, 205, 0.4, Interpolation::Direction::SOUTH_WEST, 987)
      .returns([198, 206])

    original = new_snapshot

    storage = mock
    storage.expects(:current).returns(original)

    interpolatator = Snapshot::Interpolator.new(snapshot_storage: storage)
    interpolated = interpolatator.interpolate

    assert_equal(98, interpolated[:player][:x])
    assert_equal(101, interpolated[:player][:y])

    assert(original[:entities][0] == interpolated[:entities][0])

    assert_equal(198, interpolated[:entities][1][:x])
    assert_equal(206, interpolated[:entities][1][:y])

    assert(original.object_id != interpolated.object_id)
    assert(original[:player].object_id != interpolated[:player].object_id)
    assert(original[:entities].object_id != interpolated[:entities].object_id)
    assert(original[:entities][0].object_id != interpolated[:entities][0].object_id)
  end

  private
  def new_snapshot
    {
      player: {
        x: 100,
        y: 100,
        movement: {
          direction: Interpolation::Direction::NORTH,
          speed: 0.1
        }
      },
      entities: [
        {
          x: 101,
          y: 100
        },
        {
          x: 200,
          y: 205,
          movement: {
            direction: Interpolation::Direction::SOUTH_WEST,
            speed: 0.4
          }
        }
      ],
      timestamp: 987
    }
  end
end
