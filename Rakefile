require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "irbtools"
    gem.summary     = %Q{irbtools is a meta gem which installs some useful irb gems and configures your irb.}
    gem.description = %Q{irbtools is a meta gem which installs some useful irb gems and configures your irb. Simply put a require 'irbtools' in the .irbrc file in your home directory.}
    gem.email = "mail@janlelis.de"
    gem.homepage = "http://github.com/janlelis/irbtools"
    gem.authors = ["Jan Lelis"]
    gem.add_dependency 'fancy_irb',     '>=0.6.2'
    gem.add_dependency 'zucker',        '>=8'
    gem.add_dependency 'hirb',          '~>0.3'
    gem.add_dependency 'awesome_print', '~>0.3'
    gem.add_dependency 'clipboard',     '~>0.9'
    gem.add_dependency 'coderay',       '~>0.9'
    gem.add_dependency 'boson',         '~>0.3'
    gem.add_dependency 'wirble'
    gem.add_dependency 'g'
    gem.add_dependency 'guessmethod'
    gem.add_dependency 'interactive_editor'
    gem.add_dependency 'sketches'
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION').chomp : ""

  rdoc.rdoc_dir = 'doc'
  rdoc.title = "irbtools #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
