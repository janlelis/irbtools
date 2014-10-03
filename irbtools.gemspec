# -*- encoding: utf-8 -*-
require File.dirname(__FILE__) + '/lib/irbtools/configure'

Gem::Specification.new do |s|
  s.name = 'irbtools'
  s.version = Irbtools::VERSION

  s.authors               = ["Jan Lelis"]
  s.summary               = 'irbtools happy irb.'
  s.description           = "irbtools makes using Ruby's IRB easier and more fun. Put a require 'irbtools' in a .irbrc file in your home directory to get started."
  s.email                 = 'mail@janlelis.de'
  s.extra_rdoc_files      = %w[LICENSE README.rdoc]
  s.files                 = %w[lib/irbtools.rb lib/irbtools/configure.rb lib/irbtools/libraries.rb lib/irbtools/minimal.rb CHANGELOG Rakefile irbtools.gemspec]
  s.homepage              = 'https://github.com/janlelis/irbtools'
  s.required_ruby_version = '>= 1.9.2'
  s.license               = 'MIT'

  # functionality
  s.add_dependency %q<every_day_irb>, ">= #{ s.version }"
  s.add_dependency %q<binding.repl>,  "~> 3.0.0"
  s.add_dependency %q<boson>,         "~> 1.2.4"
  s.add_dependency %q<boson-more>,    "~> 0.2.2"
  s.add_dependency %q<alias>,         "~> 0.2.3"
  s.add_dependency %q<clipboard>,     "~> 1.0.5"
  s.add_dependency %q<interactive_editor>, ">= 0.0.10"

  # irb patches / display helpers
  s.add_dependency %q<fancy_irb>,     ">= 0.7.3"
  s.add_dependency %q<wirb>,          ">= 1.0.3"
  s.add_dependency %q<paint>,         ">= 0.8.7"
  s.add_dependency %q<hirb>,          "~> 0.7"
  s.add_dependency %q<coderay>,       "~> 1.1.0"

  # debugging
  s.add_dependency %q<debugging>,     "~> 1.0"
  s.add_dependency %q<awesome_print>, "~> 1.2"
  s.add_dependency %q<g>,             ">= 1.7.2"

  # introspection / docs
  s.add_dependency %q<ori>,           "~> 0.1.0"
  s.add_dependency %q<methodfinder>,  ">= 1.2.5"
  s.add_dependency %q<method_locator>,">= 0.0.4"
  s.add_dependency %q<method_source>, ">= 0.8.2"

  # information
  s.add_dependency %q<ruby_version>,  "~> 1.0"
  s.add_dependency %q<ruby_engine>,   "~> 1.0"
  s.add_dependency %q<ruby_info>,     "~> 1.0"
  s.add_dependency %q<os>,            "~> 0.9"

  len = s.homepage.size
  s.post_install_message = \
    "       ┌── " + "info ".ljust(len-2,'─')                         + "─┐\n" +
    " J-_-L │ "   + s.homepage                                       + " │\n" +
    "       ├── " + "usage ".ljust(len-2,'─')                        + "─┤\n" +
    "       │ "   + "require 'irbtools'".ljust(len,' ')              + " │\n" +
    "       └─"   + '─'*len                                          + "─┘"
end
