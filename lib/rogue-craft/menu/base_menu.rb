class Menu::BaseMenu

  def initialize(system, game_state, keymap, interface, event, color_scheme)
    @system = system
    @game_state = game_state
    @keymap = keymap
    @interface = interface
    @event = event
    @color_scheme = color_scheme
    @items = []

    create_items
    init
  end

  private
  def init
    @active_index = 0

    width = @items.max_by(&:width).width + 2
    height = @items.reduce(1) {|acc, i| acc + i.height }

    @window = @interface.center_window(height, width)
  end

  public
  def render
    @items.each_with_index do |item, index|
      item.display(@active_index, index, @window)
    end
    @window.refresh
  end

  def navigate(input)
    if @keymap.is?(input, :escape)
      @system.open_main
      return
    end

    current = @items[@active_index]

    if current.is_a?(Menu::Item::Form)
      current.navigate(input)
      return
    end

    if @keymap.is?(input, :menu_up)
      @active_index -= 1
    elsif @keymap.is?(input, :menu_down)
      @active_index += 1
    elsif @keymap.is?(input, :submit)
      @items[@active_index].data.call
    end

    max = @items.count - 1
    @active_index = max if @active_index < 0
    @active_index = 0 if @active_index > max
  end

  def close
    @items.each(&:close)

    unless @window.destroyed?
      @window.clear
      @window.refresh
      @window.delwin
    end
  end

  def clear
    @items.each(&:clear)
  end

  private
  def create_items
    raise NotImplementedError.new(__method__)
  end

  def item(name, data = nil)
    @items << Menu::Item::Field.new(name, data)
  end

  def form(fields, width, submit)
    @items << Menu::Item::Form.new(fields, @keymap, @color_scheme, width, submit)
  end

  def input(*args, **kwargs)
    Menu::Item::FormInput.new(*args, **kwargs)
  end
end
