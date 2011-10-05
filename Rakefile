# encoding: utf-8

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
require 'jeweler'

Jeweler::Tasks.new do |gem|

  gem.name = "mongov"
  gem.homepage = "http://github.com/tijmenb/mongov"
  gem.license = "MIT"
  gem.summary = %Q{Simple data viewer for MongoDB}
  gem.description = %Q{Simple data viewer for MongoDB with Sinatra}
  gem.email = "tijmen@gmail.com"
  gem.authors = ["Tijmen Brommet"]
end

Jeweler::RubygemsDotOrgTasks.new

task :default => :test