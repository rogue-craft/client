class Display::ColorScheme
  TRANSPARENT = -1

  def initialize(colorscheme_path)
    # register_rgb_type
    # @color_scheme = YAML.load(File.read(colorscheme_path), symbolize_names: true)
    # map_entities
    # @color_scheme.delete(:colors)
  end

  private

  def register_rgb_type
    # color_id = 0

    # YAML.add_domain_type("", "rgb") do |_, rgb|
    #   color_id += 1

    #   unless valid_rgb?(rgb)
    #     raise ArgumentError.new("Invalid RGB. It must be an array with three integers between 0 and 255. #{rgb} given")
    #   end

    #   rgb = rgb.map {|c| (c * 1000) / 255 }
    #   Ncurses.init_color(color_id, *rgb)
    #   color_id
    # end
  end

  def valid_rgb?(value)
    return false if !value.is_a?(Array) || value.length != 3

    value.find do |v|
      !v.is_a?(Integer) || !v.between?(0, 255)
    end.nil?
  end

  def map_entities
    pair_id = 0

    @color_scheme[:styles].each do |_, style|
      pair_id += 1

      Ncurses.init_pair(
        pair_id,
        get_color_id(style[:fg]),
        get_color_id(style[:bg])
      )

      style[:color_pair] = Ncurses.COLOR_PAIR(pair_id)
      style.delete(:fg)
      style.delete(:bg)
    end
  end

  def get_color_id(color_name)
    return TRANSPARENT unless color_name

    unless color = @color_scheme[:colors][color_name]
      raise ArgumentError.new("No such color defined: #{color_name}")
    end

    color
  end

  public

  def [](name)
    @color_scheme[:styles][name]
  end
end
