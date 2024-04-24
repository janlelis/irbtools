require_relative "irbtools/configure"
require_relative "irbtools/commands"

require "irb"

# # # # #
# Load: start
Irbtools.load_libraries(Irbtools.libraries[:start])

# # # # #
# Load: autoload
Irbtools.libraries[:autoload].each{ |constant, lib_name, gem_name|
  gem(gem_name)
  autoload(constant, lib_name)
  Irbtools.library_loaded(lib_name)
}

# # # # #
# Misc: Apply IRB options
Irbtools.configure_irb!

# # # # #
# Load: sub-session / after_rc
original_irbrc_proc = IRB.conf[:IRB_RC]
IRB.conf[:IRB_RC] = proc{
  Irbtools.load_libraries(Irbtools.libraries[:sub_session])
  original_irbrc_proc.call if original_irbrc_proc
}

# # # # #
# Load: threads
threads = []
Irbtools.libraries[:thread].each{ |_,libs|
  threads << Thread.new do
    Irbtools.load_libraries(libs)
  end
}

threads.map(&:join)

# # # # #
# Load: late
Irbtools.load_libraries(Irbtools.libraries[:late])

# # # # #
# Load: late_threads
Irbtools.libraries[:late_thread].each{ |_,libs|
  t = Thread.new do
    Irbtools.load_libraries(libs)
  end
  t.abort_on_exception = true
}

# # # # #
# Done
if msg = Irbtools.welcome_message
  puts msg
end
