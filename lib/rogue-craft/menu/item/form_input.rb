class Menu::Item::FormInput
  attr_reader :name, :label, :height, :password

  def initialize(name, label, height: 1, password: false)
    @name = name
    @label = label
    @height = height
    @password = password
  end

  def password?
    @password
  end
end
