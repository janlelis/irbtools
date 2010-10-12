# encoding: utf-8

# TODO more ;)

def send_methods(obj)
  (obj.methods + obj.private_methods(false)).map {|e| e.to_s } - Mission::OPERATORS
end

complete(:method=>"Object#ri") {|e|
 if e.arguments.empty?
   [':']
 else
   # from bond send
   (e.object.methods + e.object.private_methods(false)).map {|e| e.to_s } - Mission::OPERATORS
 end
}

# J-_-L
