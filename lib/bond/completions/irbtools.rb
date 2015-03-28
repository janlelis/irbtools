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


# # #
# base ruby

complete method: "Object#send", &send_completion
complete method: "Object#method", &send_completion
complete method: "Object#public_method", &public_send_completion
complete method: "Object#public_send", &public_send_completion

# # #
# irbtools

# methods
complete method: "#howtocall", &send_completion
complete method: "#code", &send_completion
complete method: "Object#ri", &send_completion


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
