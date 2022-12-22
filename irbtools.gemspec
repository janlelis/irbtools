# -*- encoding: utf-8 -*-
require File.dirname(__FILE__) + '/lib/irbtools/version'

Gem::Specification.new do |s|
  s.name = 'irbtools'
  s.version = Irbtools::VERSION

  s.homepage              = 'https://irb.tools'
  s.authors               = ["Jan Lelis"]
  s.email                 = ["hi@ruby.consulting"]
  s.summary               = 'Irbtools happy IRB.'
  s.description           = "The Irbtools make working with Ruby's IRB console more fun & productive."
  s.files                 = %w[
    lib/irbtools.rb
    lib/irbtools/version.rb
    lib/irbtools/configure.rb
    lib/irbtools/implementation.rb
    lib/irbtools/libraries.rb
    lib/irbtools/non_fancy.rb
    lib/irbtools/hirb.rb
    lib/irbtools/minimal.rb
    lib/irbtools/binding.rb
    Rakefile
    irbtools.gemspec
  ]
  s.extra_rdoc_files      = %w[
    README.md
    CONFIGURE.md
    CHANGELOG.md
    MIT-LICENSE.txt
  ]
  s.license               = 'MIT'

  s.required_ruby_version = '>= 3.2', '< 4.0'

  # # #
  # Dependencies

  # Core Functionality
  s.add_dependency %q<irb>,           ">= 1.6.1"
  s.add_dependency %q<every_day_irb>, "~> 2.0"
  s.add_dependency %q<fancy_irb>,     "~> 1.2", ">= 1.2.1"
  s.add_dependency %q<wirb>,          "~> 2.0", ">= 2.2.1"
  s.add_dependency %q<hirb>,          "~> 0.7", ">= 0.7.3"

  # Utils
  s.add_dependency %q<paint>,         ">= 0.9", "< 3.0"
  s.add_dependency %q<clipboard>,     "~> 1.3"
  s.add_dependency %q<interactive_editor>, "~> 0.0", ">= 0.0.10"
  s.add_dependency %q<coderay>,       "~> 1.1"
  s.add_dependency %q<debugging>,     "~> 1.1"

  # Introspection / Docs
  s.add_dependency %q<looksee>,       "~> 5.0"
  s.add_dependency %q<object_shadow>, "~> 1.1"
  s.add_dependency %q<code>,          ">= 0.9.2", "< 2.0"
  s.add_dependency %q<core_docs>,     ">= 0.9.8"
  s.add_dependency %q<methodfinder>,  "~> 2.2", ">= 2.2.2"
  s.add_dependency %q<ruby_version>,  "~> 1.0"
  s.add_dependency %q<ruby_engine>,   "~> 1.0"
  s.add_dependency %q<ruby_info>,     "~> 1.0"
  s.add_dependency %q<os>,            "~> 1.1", ">= 1.1.4"
end
