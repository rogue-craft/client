require_relative '../test_case'

class SnapshotStorageTest < TestCase

  def test_happy_path
    storage = Snapshot::Storage.new
    assert_nil(storage.current)

    snapshot = mock
    storage.add(snapshot)
    assert_equal(snapshot, storage.current)

    other_snapshot = mock
    storage.add(other_snapshot)
    assert_equal(other_snapshot, storage.current)
  end
end
