require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "irbtools-more"
    gem.summary = %Q{irbtools is a meta gem which installs some useful irb gems and configures your irb. irbtools-more adds some gems which may not build out-of-the-box.}
    gem.description = %Q{irbtools is a meta gem which installs some useful irb gems and configures your irb. irbtools-more adds some gems which may not build out-of-the-box. Simply put a require 'irbtools-more' in the .irbrc file in your home directory}
    gem.email = "mail@janlelis.de"
    gem.homepage = "http://github.com/janlelis/irbtools-more"
    gem.authors = ["Jan Lelis"]
    gem.add_dependency 'irbtools', '>= 0.8.0'
    gem.add_dependency 'drx'
    gem.add_dependency 'bond'
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION').chomp : ""

  rdoc.rdoc_dir = 'doc'
  rdoc.title = "irbtools-more #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
