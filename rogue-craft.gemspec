lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = 'rogue-craft'
  spec.version       = '0.1.0'
  spec.authors       = ['Isty001']
  spec.email         = ['isty001@gmail.com']

  spec.summary       = 'RogueCraft'
  spec.description   = 'RogueCraft desc'
  # spec.homepage      = "RogueCraft"
  spec.license       = 'GPL-3.0'

  spec.files = Dir['README.md', 'VERSION', 'Gemfile', 'Rakefile', '{bin,lib,config,resources}/**/*']

  spec.bindir        = 'bin'
  spec.executables   = ['rogue-craft']
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'eventmachine'
  spec.add_runtime_dependency 'ncursesw', '~> 1.4'
  spec.add_runtime_dependency 'gosu', '~> 1.4'
  spec.add_runtime_dependency 'os', '~> 1.0.0'
  spec.add_runtime_dependency 'state_machines', '~> 0.5'

  spec.add_runtime_dependency 'dry-auto_inject', '~> 0.9.0'
  spec.add_runtime_dependency 'dry-container', '~> 0.9.0'
  spec.add_runtime_dependency 'dry-events', '~> 0.3.0'

  spec.add_development_dependency 'minitest'
  spec.add_development_dependency 'mocha'
  spec.add_development_dependency 'rake'

  spec.add_development_dependency 'codecov'
  spec.add_development_dependency 'simplecov'
end
