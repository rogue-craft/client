module Command end
module Command::Factory end

Dir[File.dirname(__FILE__) + "/**/*.rb"].each { |f| require f unless f == __FILE__ }
