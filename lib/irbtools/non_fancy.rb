require 'irbtools/configure'

Irbtools.remove_library 'wirb/wp'
Irbtools.remove_library 'fancy_irb'
Irbtools.replace_library_callback 'paint/pa' do
  Paint.mode = 0
end
