# -*- encoding: utf-8 -*-
require File.dirname(__FILE__) + "/lib/irbtools/more/version"

Gem::Specification.new do |s|
  s.name = 'irbtools-more'
  s.version = Irbtools::More::VERSION

  s.homepage              = 'https://github.com/janlelis/irbtools'
  s.authors               = ["Jan Lelis"]
  s.email                 = ["hi@ruby.consulting"]
  s.summary               = "irbtools-more not necessary anymore: Everything's now in core irbtools."
  s.description           = "irbtools-more not necessary anymore: looksee is now part of core irbtools and the other extensions have been removed (bond) or left optional (binding_of_caller)."
  s.files                 = %w[
    lib/irbtools/more.rb
    lib/irbtools/more/version.rb
    irbtools-more.gemspec
  ]
  s.extra_rdoc_files      = %w[
    README.md
    CHANGELOG-MORE.md
    MIT-LICENSE.txt
  ]
  s.license               = 'MIT'

  s.required_ruby_version = '>= 3.2.rc1', '< 4.0'
  # s.add_dependency 'irbtools', '~> 3.2'
end

