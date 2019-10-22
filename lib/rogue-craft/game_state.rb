class GameState

  state_machine :state, initial: :in_menu do
    transition all => :closed, on: :close
    transition all => :in_game, on: :enter_game
  end
end
