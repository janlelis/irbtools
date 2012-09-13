# -*- encoding: utf-8 -*-
require 'rubygems' unless defined? Gem

Gem::Specification.new do |s|
  s.name = 'every_day_irb'
  s.version = File.read('VERSION').chomp

  s.authors               = ["Jan Lelis"]
  s.summary               = 'every_day_irb defines some helper methods that simplify life in irb.'
  s.description           = 'every_day_irb defines some helper methods that simplify life in irb.: ls, cat, rq, rrq, ld, session_history, reset!, clear'
  s.email                 = 'mail@janlelis.de'
  s.extra_rdoc_files      = %w[LICENSE]
  s.files                 = Dir.glob(%w[lib/every_day_irb.rb VERSION every_day_irb.gemspec])
  s.homepage              = 'http://github.com/janlelis/irbtools'
  s.required_ruby_version = '>= 1.8.7'
end
