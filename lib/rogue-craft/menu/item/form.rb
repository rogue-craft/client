class Menu::Item::Form < Menu::Item::BaseItem

  attr_reader :width

  def initialize(models, keymap, color_scheme, width, submit)
    @models = models
    @field_model_map = {}
    @underlying_form = nil
    @keymap = keymap
    @width = width
    @color_scheme = color_scheme
    @submit = submit
    @errors = {}
    @render_existing = false
  end

  def clear
    @render_existing = true
    @underlying_form.unpost_form
    @errors = {}
  end

  def close
    if @underlying_form
      @underlying_form.unpost_form
      @underlying_form.free_form
      @underlying_form.form_fields.each(&:free_field)
    end

    @underlying_form = nil
  end

  def display(active_index, _index, window)

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
        field.set_field_fore(@color_scheme[:menu_password_field][:color_pair])
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

    full = height
    y = full / 2

    (full - y).times { |i| win.mvaddstr(y + i, 0, " ".rjust(@width))}

    @underlying_form.post_form

    @errors.each do |field, errors|
      win.mvaddstr(y, 0, field.to_s + ': ' + errors.join(', '))
      y += 2
    end

    Ncurses::Form.pos_form_cursor(@underlying_form)

    @render_existing = false
  end

  public
  def navigate(input)
    if @keymap.is?(input, :menu_up)
      @underlying_form.form_driver(Ncurses::Form::REQ_PREV_FIELD)
      @underlying_form.form_driver(Ncurses::Form::REQ_END_LINE)
    elsif @keymap.is?(input, :menu_down)
      @underlying_form.form_driver(Ncurses::Form::REQ_NEXT_FIELD)
      @underlying_form.form_driver(Ncurses::Form::REQ_END_LINE)
    elsif @keymap.is?(input, :menu_right)
      @underlying_form.form_driver(Ncurses::Form::REQ_RIGHT_CHAR)
    elsif @keymap.is?(input, :menu_left)
      @underlying_form.form_driver(Ncurses::Form::REQ_LEFT_CHAR)
    elsif @keymap.is?(input, :start_of_line)
      @underlying_form.form_driver(Ncurses::Form::REQ_BEG_LINE)
    elsif @keymap.is?(input, :enf_of_line)
      @underlying_form.form_driver(Ncurses::Form::REQ_END_LINE)
    elsif @keymap.is?(input, :backspace)
      @underlying_form.form_driver(Ncurses::Form::REQ_DEL_PREV)
    elsif @keymap.is?(input, :delete)
      @underlying_form.form_driver(Ncurses::Form::REQ_DEL_CHAR)
    elsif @keymap.is?(input, :submit)
      @submit.call(self)
    else
      @underlying_form.form_driver(input)
    end

    @render_existing = true
  end

  def height
    full_h = @models.reduce(1) { |h, f| h + f.height + 2}

    # space for errors
    full_h * 2
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
