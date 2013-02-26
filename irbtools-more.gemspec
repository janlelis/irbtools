# -*- encoding: utf-8 -*-
require 'rubygems' unless defined? Gem
require File.dirname(__FILE__) + "/lib/irbtools/more"

Gem::Specification.new do |s|
  s.name = 'irbtools-more'
  s.version = Irbtools::More::VERSION
  s.authors               = ["Jan Lelis"]
  s.email                 = %q{mail@janlelis.de}
  s.homepage              = %q{http://github.com/janlelis/irbtools-more}
  s.summary               = 'irbtools is a "meta gem" that installs a bunch of useful irb gems and configures them for you.'
  s.description           = 'irbtools is a "meta gem" that installs a bunch of useful irb gems and configures them for you. irbtools-more adds some gems which may not build out-of-the-box. Simply put a require "irbtools/more" in the .irbrc file in your home directory.'
  s.extra_rdoc_files      = %w[LICENSE README.rdoc]
  s.files                 = Dir.glob(%w[lib/**/*.rb ]) + %w{VERSION CHANGELOG Rakefile irbtools-more.gemspec}
  s.required_ruby_version = '>= 1.8.7'
  s.add_runtime_dependency 'irbtools',  '>= 1.2.0'
  s.add_runtime_dependency %q<bond>,    '~> 0.4.1'
  # Looksee doesn't appear to work with Ruby 2.0.0-p0
  #s.add_dependency %q<looksee>, '~> 1.0.3'
  # DrX doesn't appear to work with Ruby 2.0.0-p0
  #s.add_dependency %q<drx>
end

