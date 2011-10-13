# -*- encoding: utf-8 -*-
require 'rubygems' unless defined? Gem

Gem::Specification.new do |s|
  s.name = 'irbtools'
  s.version = File.read('VERSION').chomp

  s.authors               = ["Jan Lelis"]
  s.summary               = 'irbtools is a meta gem that installs useful irb gems and configures your irb.'
  s.description           = 'irbtools is a meta gem that installs useful irb gems and configures your irb. Simply put a require "irbtools" in the .irbrc file in your home directory.'
  s.email                 = 'mail@janlelis.de'
  s.extra_rdoc_files      = %w[LICENSE README.rdoc]
  s.files                 = %w[lib/irbtools.rb lib/irbtools/configure.rb lib/irbtools/libraries.rb lib/irbtools/minimal.rb VERSION CHANGELOG Rakefile irbtools.gemspec]
  s.homepage              = 'https://github.com/janlelis/irbtools'
  s.required_ruby_version = '>= 1.8.7'

  s.add_dependency %q<paint>,         ">= 0.8.3"
  s.add_dependency %q<fancy_irb>,     ">= 0.7.1"
  s.add_dependency %q<zucker>,        ">= 11"
  s.add_dependency %q<hirb>,          "~> 0.5.0"
  s.add_dependency %q<awesome_print>, "~> 0.4.0"
  s.add_dependency %q<clipboard>,     ">= 0.9.9"
  s.add_dependency %q<coderay>,       "~> 1.0.0"
  s.add_dependency %q<boson>,         ">= 0.3.4"
  s.add_dependency %q<wirb>,          ">= 0.4.1"
  s.add_dependency %q<interactive_editor>, ">= 0.0.10"
  s.add_dependency %q<ori>,           "~> 0.1.0"
  s.add_dependency %q<sketches>,      ">= 0.1.1"
  s.add_dependency %q<g>,             ">= 1.4.0"
  s.add_dependency %q<methodfinder>,  ">= 1.2.3"
  s.add_dependency %q<method_locator>,">= 0.0.4"
  s.add_dependency %q<rvm_loader>,    ">= 1.0.0"
  s.add_dependency %q<every_day_irb>, ">= #{ s.version }"

  len = s.homepage.size
  s.post_install_message = \
   ("       ┌── " + "info ".ljust(len-2,'%')                         + "─┐\n" +
    " J-_-L │ "   + s.homepage                                       + " │\n" +
    "       ├── " + "usage ".ljust(len-2,'%')                        + "─┤\n" +
    "       │ "   + "require 'irbtools'".ljust(len,' ')              + " │\n" +
    "       └─"   + '─'*len                                          + "─┘").gsub('%', '─') # 1.8 workaround
end
