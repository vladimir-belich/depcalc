require 'rack/test'
require 'rspec'
require 'capybara/rspec'

ENV['RACK_ENV'] = 'test'

require File.expand_path '../../app.rb', __FILE__

module RSpecMixin
  include Rack::Test::Methods
  def app() App end
  def dpst() DepCalculator end
end

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
  
  config.include RSpecMixin
  config.include Capybara::DSL
  config.include Capybara::RSpecMatchers
end

Capybara.server = :webrick
Capybara.app = App
