require_relative 'irbtools/configure'

# # # # #
# Load irbtools extension packages
Irbtools.load_packages

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
# Misc: add current directory to the load path
Irbtools.add_current_directory_to_load_path!

# # # # #
# Load: sub-session / after_rc
if defined?(Ripl) && Ripl.started?
  if defined? Ripl::AfterRc
    Irbtools.libraries[:sub_session].each{ |r| Ripl.after_rcs << r }
  elsif !Irbtools.libraries[:sub_session].empty?
    warn "Couldn't load libraries in Irbtools.libraries[:sub_session]. Please install ripl-after_rc to use this feature in Ripl!"
  end
else
  original_irbrc_proc = IRB.conf[:IRB_RC]
  IRB.conf[:IRB_RC] = proc{
    Irbtools.load_libraries(Irbtools.libraries[:sub_session])
    original_irbrc_proc.call if original_irbrc_proc
  }
end

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
  Thread.new do
    Irbtools.load_libraries(libs)
  end
}

# # # # #
# Done
if msg = Irbtools.welcome_message
  puts msg
end
