class GameState

  state_machine :state, initial: :in_menu do
    transition all => :closed, on: :close
    transition all => :in_game, on: :join_game
  end
end
