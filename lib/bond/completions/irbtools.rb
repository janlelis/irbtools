# # #
# completion actions

none = ->(*){ [] }

send_completion = ->(e){
 if e.arguments.empty?
   [':']
 else
   e.object.methods.map(&:to_s) - Mission::OPERATORS
 end
}

public_send_completion = ->(e){
 if e.arguments.empty?
   [':']
 else
   e.object.public_methods.map(&:to_s) - Mission::OPERATORS
 end
}

directories = ->(e){
  if e.arguments.empty?
    ['"']
  else
    files(e).select{ |f| File.directory?(f) }
  end
}

files = ->(e){
  if e.arguments.empty?
    ['"']
  else
    files(e)
  end
}


ruby_files = ->(e){
  if e.arguments.empty?
    ['"']
  else
    Dir["./**/*.{rb,bundle,dll,so}"].map{ |f| f.sub('./', '') }.uniq
  end
}

ruby_files_with_load_path = ->(e){
  if e.arguments.empty?
    ['"']
  else
    ($:.flat_map{ |lf|
      Dir["#{lf}/**/*.{rb,bundle,dll,so}"].map{ |f| f.sub(lf + '/', '') }
    } + Gem.path.flat_map{ |gm|
      Dir["#{gm}/gems/*/lib/*.{rb,bundle,dll,so}"].map{ |f| f.sub(/^.*\//,'') }
    }).map{ |f| f.sub(/\.(?:rb|bundle|dll|so)$/, '') }.uniq
  end
}

# # #
# base ruby

complete method: "Object#send", &send_completion
complete method: "Object#method", &send_completion
complete method: "Object#public_method", &public_send_completion
complete method: "Object#public_send", &public_send_completion

complete method: "#require", search: :files, &ruby_files_with_load_path
complete method: "#rq", search: :files, &ruby_files_with_load_path
complete method: "#rerequire", search: :files, &ruby_files_with_load_path
complete method: "#rrq", search: :files, &ruby_files_with_load_path
complete method: "#require_relative", &ruby_files
complete method: "#rr", &ruby_files
complete method: "#load", &ruby_files

# # #
# irbtools

# methods
complete method: "#howtocall", &send_completion
complete method: "#code", &send_completion
complete method: "Object#ri", &send_completion

# files
complete method: "ls", &directories
complete method: "cd", &directories
complete method: "cat", &files

# nops
complete method: "#reset!", &none
complete method: "#clear", &none
complete method: "#beep", &none
complete method: "#session_history", &none
complete method: "#info", &none
complete method: "#version", &none
complete method: "#engine", &none
complete method: "#os", &none
complete method: "Object#lp", &none
