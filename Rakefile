require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "irbtools"
    gem.summary = %Q{irbtools is a meta gem which installs some great irb gems for you and configures your irb.}
    gem.description = %Q{irbtools is a meta gem which installs some great irb gems for you and configures your irb. Simply put a require 'irbtools' in the .irbrc file in your home directory.}
    gem.email = "mail@janlelis.de"
    gem.homepage = "http://github.com/janlelis/irbtools"
    gem.authors = ["Jan Lelis"]
    gem.requirements << 'You need to add http://merbi.st to your gem sources (irb_rocket)'
    gem.add_dependency 'wirble'
    gem.add_dependency 'hirb'
    gem.add_dependency 'zucker', '>=7'
    gem.add_dependency 'awesome_print'
    gem.add_dependency 'g'
    gem.add_dependency 'clipboard'
    gem.add_dependency 'guessmethod'
    gem.add_dependency 'drx'
    gem.add_dependency 'interactive_editor'
    gem.add_dependency 'coderay'
    gem.add_dependency 'irb_rocket'
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end

begin
  require 'rcov/rcovtask'
  Rcov::RcovTask.new do |test|
    test.libs << 'test'
    test.pattern = 'test/**/test_*.rb'
    test.verbose = true
  end
rescue LoadError
  task :rcov do
    abort "RCov is not available. In order to run rcov, you must: sudo gem install spicycode-rcov"
  end
end

task :test => :check_dependencies

task :default => :test

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "irbtools #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
