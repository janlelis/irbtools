# -*- encoding: utf-8 -*-
require File.dirname(__FILE__) + '/lib/irbtools/version'

Gem::Specification.new do |s|
  s.name = 'irbtools'
  s.version = Irbtools::VERSION

  s.homepage              = 'https://github.com/janlelis/irbtools'
  s.authors               = ["Jan Lelis"]
  s.email                 = ["hi@ruby.consulting"]
  s.summary               = 'Irbtools happy IRB.'
  s.description           = "The Irbtools make working with Ruby's IRB console more fun & productive."
  s.files                 = Dir["{**/}{.*,*}"].select{ |path| File.file?(path) && path !~ /^pkg/ }
  s.metadata              = { "rubygems_mfa_required" => "true" }
  s.license               = 'MIT'

  s.required_ruby_version = '>= 3.0', '< 4.0'

  # # #
  # Dependencies

  # Core Functionality
  s.add_dependency %q<irb>,           "~> 1.6.2"
  s.add_dependency %q<every_day_irb>, "~> 2.2"
  s.add_dependency %q<fancy_irb>,     "~> 1.2", ">= 1.2.1"
  s.add_dependency %q<wirb>,          "~> 2.0", ">= 2.2.1"
  s.add_dependency %q<hirb>,          "~> 0.7", ">= 0.7.3"

  # Utils
  s.add_dependency %q<paint>,         ">= 0.9", "< 3.0"
  s.add_dependency %q<clipboard>,     "~> 1.3"
  s.add_dependency %q<interactive_editor>, "~> 0.0", ">= 0.0.10"
  s.add_dependency %q<coderay>,       "~> 1.1"
  s.add_dependency %q<debugging>,     "~> 2.1"

  # Introspection / Docs
  s.add_dependency %q<looksee>,       "~> 5.0"
  s.add_dependency %q<object_shadow>, "~> 1.1"
  s.add_dependency %q<code>,          ">= 0.9.4", "< 2.0"
  s.add_dependency %q<core_docs>,     "~> 0.9.9"
  s.add_dependency %q<methodfinder>,  "~> 2.2", ">= 2.2.5"
  s.add_dependency %q<ruby_version>,  "~> 1.0"
  s.add_dependency %q<ruby_engine>,   "~> 2.0"
  s.add_dependency %q<os>,            "~> 1.1", ">= 1.1.4"
end
