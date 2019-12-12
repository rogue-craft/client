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

  def closed?; @closed end
  def in_menu?; @in_menu end
  def in_game?; @in_game end
end
