class Loop

  include Dependency[:game_state, :interface, :menu_system, :event, :renderer, :interpolator]

  def update
    unless @game_state.closed?
      begin
        process_input
        render
      rescue Exception => err
        close(err)
      end
    else
      close
    end
  end

  private
  def process_input
    until -1 == (input = @interface.read_input)
      if @game_state.in_game?
        @event.publish(:input, {input: input})
      else
        @menu_system.navigate(input)
      end
    end
    @event.publish(:end_of_input)
  end

  def render
    if @game_state.in_game?
      @renderer.render
    end

    if @game_state.in_menu?
      @menu_system.render
    end
  end

  public
  def close(err = nil)
    @game_state.close
    @menu_system.close
    @interface.close

    EventMachine.stop if EventMachine.reactor_running?

    if err && !err.is_a?(Interrupt)
      raise err
    end
  end
end
