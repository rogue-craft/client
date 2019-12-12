module Display end

Dir[File.dirname(__FILE__) + "/*.rb"].each { |f| require f unless __FILE__ == f }

require_relative 'renderer/renderer'
require_relative 'renderer/world'
