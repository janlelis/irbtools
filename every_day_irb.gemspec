# -*- encoding: utf-8 -*-
require File.dirname(__FILE__) + '/lib/irbtools/configure'

Gem::Specification.new do |s|
  s.name = 'every_day_irb'
  s.version = Irbtools::VERSION

  s.authors               = ["Jan Lelis"]
  s.summary               = 'every_day_irb defines helper methods that simplify life in irb.'
  s.description           = 'every_day_irb defines helper methods that simplify life in irb.: ls, cat, rq, rrq, ld, session_history, reset!, clear, ...'
  s.email                 = 'mail@janlelis.de'
  s.extra_rdoc_files      = %w[CHANGELOG.txt MIT-LICENSE.txt README.md]
  s.files                 = Dir.glob(%w[lib/every_day_irb.rb every_day_irb.gemspec])
  s.homepage              = 'http://github.com/janlelis/irbtools'
  s.required_ruby_version = '>= 1.9.3'
  s.license               = 'MIT'
  s.add_development_dependency %q<rspec>
  s.add_development_dependency %q<rake>
end
