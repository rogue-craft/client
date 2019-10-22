module Menu end
module Menu::Item end

require_relative './base_menu'

Dir[File.dirname(__FILE__) + "/**/*.rb"].each { |f| require f unless __FILE__ == f }
