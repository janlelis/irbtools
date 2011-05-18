# -*- encoding: utf-8 -*-
require 'rubygems' unless defined? Gem
require File.dirname(__FILE__) + "/lib/irbtools/more"

Gem::Specification.new do |s|
  s.name = 'irbtools-more'
  s.version = Irbtools::More::VERSION
  s.authors               = ["Jan Lelis"]
  s.email                 = %q{mail@janlelis.de}
  s.homepage              = %q{http://github.com/janlelis/irbtools-more}
  s.description           = %q{irbtools is a meta gem that installs useful irb gems and configures your irb. irbtools-more adds some gems which may not build out-of-the-box. Simply put a require 'irbtools/more' in the .irbrc file in your home directory}
  s.summary               = %q{irbtools is a meta gem that installs useful irb gems and configures your irb.}
  s.extra_rdoc_files      = %w[LICENSE README.rdoc]
  s.files                 = Dir.glob(%w[lib/**/*.rb ]) + %w{VERSION CHANGELOG Rakefile irbtools-more.gemspec}
  s.required_ruby_version = '>= 1.8.7'
  s.add_dependency 'irbtools', '>= 1.0.0'
  s.add_dependency 'drx'
  s.add_dependency 'bond'
end

