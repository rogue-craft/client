# @!attribute [r] game_state
#   @return [GameState]
#
# @!attribute [r] menu_system
#   @return [Menu::MenuSystem]
#
class Loop
  include Dependency[:game_state, :interface, :menu_system, :event, :renderer]

  def initialize(**args)
    super

    register_events
  end

  private

  def register_events
    Ruby2D::Window.on(:key_down) do |event|
      puts event.key

      menu_system.navigate(event.key) if game_state.in_menu?
    end
  end

  public

  def update
    menu_system.update if game_state.in_menu?

    # unless @game_state.closed?
    #   begin
    #     process_input
    #     render
    #   rescue Exception => err
    #     close(err)
    #   end
    # else
    #   close
    # end
  end

  private

  def process_input
    # until -1 == (input = @interface.read_input)
    #   if @game_state.in_game?
    #     @event.publish(:input, {input: input})
    #   else
    #     @menu_system.navigate(input)
    #   end
    # end
    # @event.publish(:end_of_input)
  end

  def render
    # if @game_state.in_game?
    #   @renderer.render
    # end

    menu_system.display if game_state.in_game?
  end

  public

  def close(_err = nil)
    @game_state.close
    @menu_system.close
    @interface.close

    EventMachine.stop if EventMachine.reactor_running?

    # if err && !err.is_a?(Interrupt)
    #   raise err
    # end
  end
end
