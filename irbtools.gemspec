# -*- encoding: utf-8 -*-
require File.dirname(__FILE__) + '/lib/irbtools/version'

Gem::Specification.new do |s|
  s.name = 'irbtools'
  s.version = Irbtools::VERSION

  s.homepage              = 'https://github.com/janlelis/irbtools'
  s.authors               = ["Jan Lelis"]
  s.summary               = 'Irbtools happy IRB.'
  s.description           = "Irbtools make Ruby's IRB more productive."
  s.email                 = 'mail@janlelis.de'
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
    CHANGELOG.txt
    MIT-LICENSE.txt
  ]
  s.license               = 'MIT'

  s.required_ruby_version = '~> 2.0'
  s.add_development_dependency 'rspec', '~> 3.2'
  s.add_development_dependency 'rake', '~> 10.4'

  # # #
  # Dependencies

  # core functionality
  s.add_dependency %q<every_day_irb>, "~> 2.0"
  s.add_dependency %q<fancy_irb>,     "~> 1.1"
  s.add_dependency %q<wirb>,          "~> 2.0"
  s.add_dependency %q<hirb>,          "~> 0.7", ">= 0.7.3"
  s.add_dependency %q<binding.repl>,  "~> 3.0"

  # utils
  s.add_dependency %q<paint>,         ">= 0.9", "< 2.0"
  s.add_dependency %q<clipboard>,     "~> 1.1"
  s.add_dependency %q<interactive_editor>, "~> 0.0", ">= 0.0.10"
  s.add_dependency %q<coderay>,       "~> 1.1"
  s.add_dependency %q<debugging>,     "~> 1.1"

  # introspection / docs
  s.add_dependency %q<code>,          "~> 0.9"
  s.add_dependency %q<ori>,           "~> 0.1.0"
  s.add_dependency %q<methodfinder>,  "~> 2.0"
  s.add_dependency %q<method_locator>,"~> 0.0", ">= 0.0.4"
  s.add_dependency %q<ruby_version>,  "~> 1.0"
  s.add_dependency %q<ruby_engine>,   "~> 1.0"
  s.add_dependency %q<ruby_info>,     "~> 1.0"
  s.add_dependency %q<os>,            "~> 1.0"
  s.add_dependency %q<instance>,      "~> 0.2"
end
