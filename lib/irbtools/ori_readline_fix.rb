# TODO Readline history can be empty (issue)
module ORI::Internals
  def self.get_ri_arg_prefix(cmd)
    if cmd && (mat = cmd.match /\A(\s*.+?\.ri)\s+\S/)
      mat[1]
    end
  end
end
