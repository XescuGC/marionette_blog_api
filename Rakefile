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

RSpec::Core::RakeTask.new(:spec, :dir) do |t, task_args|
  if task_args[:dir]
    t.pattern = "spec/domine/#{task_args[:dir]}/**/*_spec.rb"
  end
end

task routes: :environment do
  MarionetteBlog::API::routes.each do |route|
    p "#{route.route_method}  #{route.route_path} #{route.route_description}"
  end
end

require 'rubocop/rake_task'
RuboCop::RakeTask.new(:rubocop)

task default: [:rubocop, :spec]
