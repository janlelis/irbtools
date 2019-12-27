# -*- encoding: utf-8 -*-
require File.dirname(__FILE__) + "/lib/irbtools/more/version"

Gem::Specification.new do |s|
  s.name = 'irbtools-more'
  s.version = Irbtools::More::VERSION

  s.homepage              = 'https://github.com/janlelis/irbtools'
  s.authors               = ["Jan Lelis"]
  s.summary               = 'irbtools-more adds bond and looksee to IRB.'
  s.description           = 'irbtools-more adds bond and looksee to IRB (Gems that use core extensions). Simply put a require "irbtools/more" in the .irbrc file in your home directory to get started.'
  s.email                 = 'mail@janlelis.de'
  s.files                 = %w[
    lib/irbtools/more.rb
    lib/irbtools/more/version.rb
    lib/bond/completions/irbtools.rb
    irbtools-more.gemspec
  ]
  s.extra_rdoc_files      = %w[
    README.md
    CHANGELOG-MORE.md
    MIT-LICENSE.txt
  ]
  s.license               = 'MIT'

  s.required_ruby_version = '~> 2.0'
  s.add_dependency 'irbtools', '>= 2.2', '< 4.0'
  s.add_dependency 'bond',     '~> 0.5'
  s.add_dependency 'looksee' , '~> 4.2'
  s.add_dependency 'core_docs', '>= 0.9.5'
  s.add_dependency 'binding_of_caller', '~> 0.8'
end

