# test if installed
unless rvm_path = ENV['rvm_path']
  raise 'Ruby Version Manager must be installed to use this command'
end

# load rvm ruby api
$LOAD_PATH.unshift File.join(rvm_path, 'lib')
require 'rvm'
