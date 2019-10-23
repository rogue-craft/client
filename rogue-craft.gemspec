lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)


Gem::Specification.new do |spec|
  spec.name          = "rogue-craft"
  spec.version       = "0.1.0"
  spec.authors       = ["Isty001"]
  spec.email         = ["isty001@gmail.com"]

  spec.summary       = 'RogueCraft'
  spec.description   = 'RogueCraft desc'
  # spec.homepage      = "RogueCraft"
  spec.license       = "MIT"

  spec.files = Dir['README.md', 'VERSION', 'Gemfile', 'Rakefile', '{bin,lib,config,vendor}/**/*']

  spec.bindir        = "bin"
  spec.executables   = ["rogue-craft"]
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "state_machines", "~> 0.5"
  spec.add_runtime_dependency "ncursesw", "~> 1.4"
  spec.add_runtime_dependency "eventmachine", "~> 1.2.7"

  spec.add_runtime_dependency "dry-container", "~> 0.6.0"
  spec.add_runtime_dependency "dry-auto_inject", "~> 0.6.0"
  spec.add_runtime_dependency "dry-events", "~> 0.1.0"

  spec.add_runtime_dependency "dotenv", "~> 2.6"

  spec.add_development_dependency "bundler", "~> 2"
  spec.add_development_dependency "rake", "~> 12.0"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "mocha", "~> 1.8"
end
