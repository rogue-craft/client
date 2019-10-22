module Event end
module Event::Listener end

Dir[File.dirname(__FILE__) + "/**/*.rb"].each { |f| require f unless f == __FILE__ }
