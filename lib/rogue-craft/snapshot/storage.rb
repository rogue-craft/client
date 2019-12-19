class Snapshot::Storage

  def initialize
    @current = nil
  end

  def add(snapshot)
    @current = snapshot
  end

  def current
    @current
  end
end
