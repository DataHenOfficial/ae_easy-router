$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require_relative './input/classes/parsers'
require_relative './input/classes/seeders'
$LOAD_PATH.unshift File.expand_path("./test/input", __FILE__)

require 'simplecov'
require 'simplecov-console'
SimpleCov.formatter = SimpleCov::Formatter::Console
SimpleCov.start

require 'minitest'
require 'minitest/spec'
require 'minitest/autorun'
require 'concurrent'
require 'timecop'
require 'byebug'
require 'dh_easy/router'
