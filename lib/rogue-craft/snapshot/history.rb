class Snapshot::History

  def initialize(limit)
    @limit = limit
    @queue = []
  end

  def push(snapshot)
    if 2 < @queue.count
      @queue.shift
    end

    @queue.push(snapshot)
  end

  def relevant
    last = @queue[-1]
    prev = @queue[-2]

    return last unless prev

    if ((Time.now.to_f * 1000) - prev[:timestamp]).floor < @limit
      return prev
    end

    last
  end

  def clear
    @queue = []
  end
end
