class Menu::Item::Form < Menu::Item::BaseItem

  attr_reader :width, :success

  def initialize(models, keymap, color_bag, width, submit, success)
    @models = models
    @field_model_map = {}
    @underlying_form = nil
    @keymap = keymap
    @width = width
    @color_bag = color_bag
    @submit = submit
    @success = success
    @errors = {}
    @render_existing = false
  end

  def close
    if @underlying_form
      @underlying_form.unpost_form
      @underlying_form.free_form
      @underlying_form.form_fields.each(&:free_field)
    end

    @underlying_form = nil
  end

  def display(active_index, index, window)

    if @underlying_form
      display_existing
      return
    end

    underlying_fields = @models.flat_map.with_index do |model, i|

      label = Ncurses::Form.new_field(1, model.label.length, i * 3, 0, 0, 0)
      label.set_field_buffer(0, model.label)
      label.field_opts_off(Ncurses::Form::O_ACTIVE)

      field = Ncurses::Form.new_field(model.height, @width, 1 + (i * 3), 0, 0, 0)

      field.set_field_back(Ncurses::A_UNDERLINE)
      field.field_opts_off(Ncurses::Form::O_AUTOSKIP)
      field.field_opts_off(Ncurses::Form::O_STATIC)

      if model.password?
        field.set_field_fore(@color_bag.get(fg: Ncurses::COLOR_BLACK, bg: Ncurses::COLOR_BLACK))
      end

      @field_model_map[field] = model

      [label, field]
    end

    form = Ncurses::Form.new_form(underlying_fields)
    form.set_form_win(window)
    form.set_form_sub(window.derwin(0, 0, window.getmaxy, window.getmaxx))
    form.post_form

    @underlying_form = form
  end

  private
  def display_existing
    return unless @render_existing

    win = @underlying_form.form_win
    curr = @underlying_form.current_field

    @underlying_form.form_fields.each.with_index do |field, i|
      model = @field_model_map[field]

      next if model && model.password?

      field.set_field_back(field == curr ? Ncurses::A_BOLD : Ncurses::A_UNDERLINE)
    end

    full = height
    y = full / 2

    (full - y).times { |i| win.mvaddstr(y + i, 0, " ".rjust(@width))}

    @errors.each do |field, errors|
      win.mvaddstr(y, 0, field.to_s + ': ' + errors.join(', '))
      y += 2
    end

    @render_existing = false
  end

  public
  def navigate(input)
    case input
    when @keymap[:menu_up]
      @underlying_form.form_driver(Ncurses::Form::REQ_PREV_FIELD)
      @underlying_form.form_driver(Ncurses::Form::REQ_END_LINE)
   when @keymap[:menu_down]
      @underlying_form.form_driver(Ncurses::Form::REQ_NEXT_FIELD)
      @underlying_form.form_driver(Ncurses::Form::REQ_END_LINE)
    when Ncurses::KEY_BACKSPACE
      @underlying_form.form_driver(Ncurses::Form::REQ_DEL_PREV)
    when @keymap[:enter]
      @submit.call(self)
    else
      @underlying_form.form_driver(input)
    end
  end

  def height
    h = @models.reduce(1) { |h, f| h + f.height + 2}

    # space for errors
    h * 2
  end

  def data
    @underlying_form.form_driver(Ncurses::Form::REQ_END_LINE)

    @field_model_map.map do |f, m|
      [m.name, f.field_buffer(0).strip]
    end
      .to_h
      .reject { |_, val| val.empty? }
  end

  def errors=(errors)
    @errors = errors
    @render_existing = true
  end
end
