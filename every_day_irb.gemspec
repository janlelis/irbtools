# -*- encoding: utf-8 -*-
require File.dirname(__FILE__) + '/lib/every_day_irb/version'

Gem::Specification.new do |s|
  s.name = 'every_day_irb'
  s.version = EveryDayIrb::VERSION

  s.homepage              = 'http://github.com/janlelis/irbtools'
  s.authors               = ["Jan Lelis"]
  s.summary               = 'EveryDayIrb simplifies daily life in IRB.'
  s.description           = 'EveryDayIrb simplifies daily life in IRB with commands like: ls, cat, rq, rrq, ld, reset!, ...'
  s.email                 = 'mail@janlelis.de'
  s.files                 = %w[
    lib/every_day_irb.rb
    lib/every_day_irb/version.rb
    spec/every_day_irb_spec.rb
    every_day_irb.gemspec
  ]
  s.extra_rdoc_files      = %w[
    README.md
    CHANGELOG-EVERYDAYIRB.txt
    MIT-LICENSE.txt
  ]
  s.license               = 'MIT'

  s.required_ruby_version = '>= 1.9.3'
  s.add_dependency 'cd', '~> 1.0'
end
