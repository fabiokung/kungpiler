#!/usr/bin/env ruby
#
#  Created by Fabio  Correia Kung on 2007-09-11.
#  Copyright (c) 2007. All rights reserved.
require "rubygems"
require "rake"
require "spec/rake/spectask"
# require "redgreen"

desc "Run all tests under test/"
Spec::Rake::SpecTask.new('test') do |t|
  t.spec_files = FileList['test/**/*_spec.rb']
end
# task :test do |t|
#   require 'test/unit'
#   Dir['test/**/*_test.rb'].each do |test|
#     require test
#   end
# end
