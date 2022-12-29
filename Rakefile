require 'fileutils'
require "rspec/core/rake_task"

task :test => :spec
task :default => :spec
RSpec::Core::RakeTask.new(:spec) do |t|
  t.rspec_opts = '--backtrace --color'
end

def gemspec2
  @gemspec2 ||= eval(File.read('irbtools.gemspec'), binding, 'irbtools.gemspec')
end

desc "Build the gems"
task :gem => :gemspec do
  sh "gem build #{gemspec2.name}.gemspec"
  FileUtils.mkdir_p 'pkg'
  FileUtils.mv "#{gemspec2.name}-#{gemspec2.version}.gem", 'pkg'
end

desc "Install the gem locally (without docs)"
task :install => :gem do
  sh %{gem install pkg/#{gemspec2.name}-#{gemspec2.version}.gem --no-document}
end

desc "Validate the gemspec"
task :gemspec do
  gemspec2.validate
end
