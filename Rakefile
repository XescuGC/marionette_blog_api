require 'rubygems'
require 'bundler'

begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end

require 'rake'

require 'rspec/core'
require 'rspec/core/rake_task'
require_relative 'config/environment'

desc "To run the Tests"
RSpec::Core::RakeTask.new(:spec, :type, :dir) do |t, task_args|
  if task_args[:type] && task_args[:dir]
    t.pattern = "spec/#{task_args[:type]}/#{task_args[:dir]}/**/*_spec.rb"
  elsif task_args[:type]
    t.pattern = "spec/#{task_args[:type]}/**/*_spec.rb"
  end
end

desc 'Return the routes'
task :routes do
  MarionetteBlog::API::routes.each do |route|
    p "#{route.route_method}  #{route.route_path} #{route.route_description}"
  end
end

require 'rubocop/rake_task'
RuboCop::RakeTask.new(:rubocop)

task default: [:rubocop, :spec]
