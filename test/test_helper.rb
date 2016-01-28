require 'codeclimate-test-reporter'
CodeClimate::TestReporter.start

require 'simplecov'
SimpleCov.start

require 'minitest/autorun'

ENV['DATABASE_URL'] = "postgres://postgres@#{ENV['DOCKER_IP']}/investment-tracking-infrastructure_test"
