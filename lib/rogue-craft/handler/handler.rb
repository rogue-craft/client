module Handler end

require_relative './authenticated_handler'

Dir[File.dirname(__FILE__) + "/*.rb"].each { |f| require f unless __FILE__ == f }
