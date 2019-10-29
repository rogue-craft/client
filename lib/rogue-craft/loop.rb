class Loop

  include Dependency[:game_state, :interface, :keymap, :menu_system, :renderer, :event]

  def update
    unless @game_state.closed?
      begin

        until -1 == (input = @interface.read_input)
          if @game_state.in_menu?
            @menu_system.navigate(input)
          else
            dispatch_input(input)
          end
        end

        if game_state.in_menu?
          @menu_system.render
        else
          @renderer.render
        end
      rescue Exception => err
        close(err)
      end
    else
      close
    end
  end

  private
  def dispatch_input(input)
    if @keymap.camera_keys.include?(input)
      # @event.publish(:camera_movement, key: input)
    end
  end

  public
  def close(err = nil)
    @game_state.close
    @menu_system.close
    @interface.close

    EventMachine.stop

    if err && !err.is_a?(Interrupt)
      raise err
    end
  end
end
