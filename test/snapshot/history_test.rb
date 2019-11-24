require_relative '../test_case'

class SnapshotHistoryTest < TestCase

  def test_one_snapshot
    histoy = Snapshot::History.new(10)

    snapshot = {}
    histoy.push(snapshot)

    assert_same(snapshot, histoy.relevant)
  end

  def test_happy_path
    histoy = Snapshot::History.new(10)

    time = mock
    time.expects(:to_f).returns(100.009)
    Time.expects(:now).returns(time)

    prev = {timestamp: 100_000.0}
    last = {}
    histoy.push(prev)
    histoy.push(last)

    assert_same(prev, histoy.relevant)
  end

  def test_outdated
    histoy = Snapshot::History.new(10)

    Time.expects(:now).returns(111)

    prev = {timestamp: 100}
    last = {}
    histoy.push(prev)
    histoy.push(last)

    assert_same(last, histoy.relevant)
  end

  def test_no_snapshot
    histoy = Snapshot::History.new(10)
    assert_nil(histoy.relevant)
  end

  def test_clear
    histoy = Snapshot::History.new(10)
    histoy.push({})
    histoy.push({})
    histoy.push({})

    histoy.clear

    assert_nil(histoy.relevant)
  end
end
