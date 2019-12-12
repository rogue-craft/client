module Schema::Snapshot
  class Entity < Dry::Schema::Params
    define do
      required(:x).filled(:integer)
      required(:y).filled(:integer)
    end
  end

  class Player < Entity
    define do
      required(:name).filled(:string)
    end
  end

  class Receive < Dry::Validation::Contract
    params do
      required(:player).filled(Player.new)
      required(:entities).each(Entity.new)
      required(:timestamp).filled(:float)
    end
  end
end
