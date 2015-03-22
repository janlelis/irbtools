# -*- encoding: utf-8 -*-
require File.dirname(__FILE__) + '/lib/irbtools/configure'

Gem::Specification.new do |s|
  s.name = 'irbtools'
  s.version = Irbtools::VERSION

  s.authors               = ["Jan Lelis"]
  s.summary               = 'irbtools happy irb.'
  s.description           = "irbtools makes using Ruby's IRB easier and more fun."
  s.email                 = 'mail@janlelis.de'
  s.files                 = %w[
    lib/irbtools.rb
    lib/irbtools/configure.rb
    lib/irbtools/libraries.rb
    lib/irbtools/minimal.rb
    lib/irbtools/binding.rb
    Rakefile
    irbtools.gemspec
  ]
  s.extra_rdoc_files      = %w[
    README.md
    CHANGELOG.txt
    MIT-LICENSE.txt
  ]
  s.homepage              = 'https://github.com/janlelis/irbtools'
  s.required_ruby_version = '>= 1.9.3'
  s.license               = 'MIT'

  # core functionality
  s.add_dependency %q<every_day_irb>, ">= #{ s.version }"
  s.add_dependency %q<fancy_irb>,     "= 1.0.0.pre"
  s.add_dependency %q<wirb>,          "= 2.0.0.pre"
  s.add_dependency %q<hirb>,          "~> 0.7", ">= 0.7.3"
  s.add_dependency %q<binding.repl>,  "~> 3.0"

  # utils
  s.add_dependency %q<paint>,         "= 1.0.0.pre"
  s.add_dependency %q<clipboard>,     "~> 1.0.6"
  s.add_dependency %q<interactive_editor>, ">= 0.0.10"
  s.add_dependency %q<alias>,         "~> 0.2.3"
  s.add_dependency %q<coderay>,       "~> 1.1.0"
  s.add_dependency %q<debugging>,     "~> 1.0", ">= 1.0.2"
  s.add_dependency %q<g>,             ">= 1.7.2"

  # introspection / docs
  s.add_dependency %q<ori>,           "~> 0.1.0"
  s.add_dependency %q<methodfinder>,  "~> 2.0"
  s.add_dependency %q<method_locator>,">= 0.0.4"
  s.add_dependency %q<method_source>, ">= 0.8.2"
  s.add_dependency %q<ruby_version>,  "~> 1.0"
  s.add_dependency %q<ruby_engine>,   "~> 1.0"
  s.add_dependency %q<ruby_info>,     "~> 1.0"
  s.add_dependency %q<os>,            "~> 0.9"
  s.add_dependency %q<instance>,      "~> 0.2"
end
