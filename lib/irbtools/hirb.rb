Irbtools.add_library :hirb, thread: :paint do
  Hirb::View.enable output: { "Object" => { ancestor: true, options: { unicode: true }}},
                    pager_command: 'less -R'
  extend Hirb::Console

  def page(what, options = {})
    Hirb::Pager.command_pager(what, options = {})
  end

  # page wirb output hacks
  class Hirb::Pager
    alias original_activated_by? activated_by?
    def activated_by?(string_to_page, inspect_mode=false)
      original_activated_by?(Paint.unpaint(string_to_page || ''), inspect_mode)
    end
  end

  class << Hirb::View
    def view_or_page_output(val)
      if defined?(val.inspect)
        unless view_output(val)
          if defined?(Wirb) && Wirb.running?
            page_output Wirb.colorize_result_with_timeout(val.inspect), true
          else
            page_output val.inspect, true
          end
        end
      end
    end
  end

  # colorful border
  table_color = :yellow
  Hirb::Helpers::UnicodeTable::CHARS.each do |place, group|
    Hirb::Helpers::UnicodeTable::CHARS[place] =
    group.each do |name, part|
      if part.kind_of? String
        Hirb::Helpers::UnicodeTable::CHARS[place][name] = Paint[part, *table_color]
      elsif part.kind_of? Hash
        part.each do |special, char|
          Hirb::Helpers::UnicodeTable::CHARS[place][name][special] = Paint[char, *table_color]
        end
      end
    end
  end
end
