class Snapshot::Storage

  attr_reader :current

  def initialize
    @current = nil
  end

  def add(snapshot)
    @current = snapshot.freeze
  end
end
