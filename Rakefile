require 'fileutils'
require "rspec/core/rake_task"


task :test => :spec
task :default => :spec
RSpec::Core::RakeTask.new(:spec) do |t|
  t.rspec_opts = '--backtrace --color'
end


def gemspec1
  @gemspec1 ||= eval(File.read('every_day_irb.gemspec'), binding, 'every_day_irb.gemspec')
end

def gemspec2
  @gemspec2 ||= eval(File.read('irbtools.gemspec'), binding, 'irbtools.gemspec')
end

def gemspec3
  @gemspec3 ||= eval(File.read('irbtools-more.gemspec'), binding, 'irbtools-more.gemspec')
end

desc "Build the gems"
task :gem => :gemspec do
  sh "gem build #{gemspec1.name}.gemspec"
  sh "gem build #{gemspec2.name}.gemspec"
  sh "gem build #{gemspec3.name}.gemspec"
  FileUtils.mkdir_p 'pkg'
  FileUtils.mv "#{gemspec1.name}-#{gemspec1.version}.gem", 'pkg'
  FileUtils.mv "#{gemspec2.name}-#{gemspec2.version}.gem", 'pkg'
  FileUtils.mv "#{gemspec3.name}-#{gemspec3.version}.gem", 'pkg'
end

desc "Install the gem locally (without docs)"
task :install => :gem do
  sh %{gem install pkg/#{gemspec1.name}-#{gemspec1.version}.gem --no-document}
  sh %{gem install pkg/#{gemspec2.name}-#{gemspec2.version}.gem --no-document}
  sh %{gem install pkg/#{gemspec3.name}-#{gemspec3.version}.gem --no-document}
end

desc "Validate the gemspec"
task :gemspec do
  gemspec1.validate
  gemspec2.validate
  gemspec3.validate
end
