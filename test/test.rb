$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)

require_relative "../lib/rogue-craft/container_loader"

require "minitest/autorun"
require 'mocha/minitest'

Dependency.container.config.resolver = -> (container, key) { nil }
