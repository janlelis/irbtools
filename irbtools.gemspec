# -*- encoding: utf-8 -*-
require 'rubygems' unless defined? Gem

Gem::Specification.new do |s|
  s.name = %q{irbtools}
  s.version = File.read('VERSION').chomp

  s.authors               = ["Jan Lelis"]
  s.date                  = %q{2010-12-14}
  s.summary               = %q{irbtools is a meta gem which installs some useful irb gems and configures your irb.}
  s.description           = %q{irbtools is a meta gem which installs some useful irb gems and configures your irb. Simply put a require 'irbtools' in the .irbrc file in your home directory.}
  s.email                 = %q{mail@janlelis.de}
  s.extra_rdoc_files      = %w[LICENSE README.rdoc]
  s.files                 = Dir.glob(%w[lib/**/*.rb ]) + %w{VERSION CHANGELOG Rakefile irbtools.gemspec}
  s.homepage              = %q{http://github.com/janlelis/irbtools}
  s.required_ruby_version = '>= 1.8.7'

  s.add_dependency %q<fancy_irb>,     ">= 0.6.4"
  s.add_dependency %q<zucker>,        ">= 9"
  s.add_dependency %q<hirb>,          "~> 0.3"
  s.add_dependency %q<awesome_print>, "~> 0.3"
  s.add_dependency %q<clipboard>,     ">= 0.9.4"
  s.add_dependency %q<coderay>,       "~> 0.9"
  s.add_dependency %q<boson>,         "~> 0.3"
  s.add_dependency %q<wirb>,          ">= 0.2.0"
  s.add_dependency %q<interactive_editor>, ">= 0.0.6"
  s.add_dependency %q<sketches>,      ">= 0"
  s.add_dependency %q<g>,             ">= 0"
  s.add_dependency %q<guessmethod>,   ">= 0"
end
