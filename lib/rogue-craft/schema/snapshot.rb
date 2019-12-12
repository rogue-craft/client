module Schema::World
  class Entity < Dry::Schema::Params
    define do
      required(:x).filled(:integer)
      required(:y).filled(:integer)
    end
  end

  class Player < Entity
    define do
    end
  end

  class Snapshot < Dry::Validation::Contract
    params do
      required(:player).filled(Player.new)
      required(:entities).each(Entity.new)
      required(:timestamp).filled(:float)
    end
  end
end
