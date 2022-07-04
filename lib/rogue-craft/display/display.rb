module Display end

Dir["#{File.dirname(__FILE__)}/*.rb"].each { |f| require f unless f == __FILE__ }

require_relative 'renderer/renderer'
require_relative 'renderer/world'
