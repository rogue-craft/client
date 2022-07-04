class GameState
  def initialize
    @in_menu = true
    @in_game = false
    @closed = false
  end

  def close
    @closed = true
  end

  def close_menu
    @in_menu = false
  end

  def join_game
    @in_game = true
  end

  def closed? = @closed
  def in_menu? = @in_menu
  def in_game? = @in_game
end
