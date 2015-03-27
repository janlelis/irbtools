# -*- encoding: utf-8 -*-
require File.dirname(__FILE__) + '/lib/irbtools/configure'

Gem::Specification.new do |s|
  s.name = 'every_day_irb'
  s.version = Irbtools::VERSION

  s.homepage              = 'http://github.com/janlelis/irbtools'
  s.authors               = ["Jan Lelis"]
  s.summary               = 'EveryDayIrb simplifies daily life in IRB.'
  s.description           = 'EveryDayIrb simplifies daily life in IRB: ls, cat, rq, rrq, ld, reset!, clear, ...'
  s.email                 = 'mail@janlelis.de'
  s.files                 = %w[lib/every_day_irb.rb spec/every_day_irb_spec.rb every_day_irb.gemspec]
  s.extra_rdoc_files      = %w[CHANGELOG.txt MIT-LICENSE.txt README.md]
  s.license               = 'MIT'

  s.required_ruby_version = '>= 1.9.3'
  s.add_dependency 'cd', '~> 1.0'
end
