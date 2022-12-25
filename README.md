# Irbtools [![[version]](https://badge.fury.io/rb/irbtools.svg)](https://badge.fury.io/rb/irbtools)  [![[ci]](https://github.com/janlelis/irbtools/workflows/Test/badge.svg)](https://github.com/janlelis/irbtools/actions?query=workflow%3ATest)

## Irbtools 4.0 for IRB 1.6+

The current version of Irbtools requires IRB 1.6+ (which is the default for Ruby
from 3.2 on). Please use Irbtools 3 for earlier versions of IRB.

## Description

Improves Ruby's IRB with:

- a default configuration
- better syntax highlighting of result objects
- helpful methods for debugging and introspection

## Setup

    $ gem install irbtools

IRB executes code in `~/.irbrc` on start-up. If the file does not exist, yet,
just create a new one. Add the following content:

    require 'irbtools'

You also need to add irbtools to your project's `Gemfile`:

    gem 'irbtools', require: 'irbtools/binding'

Then start IRB (with **Irbtools** loaded) from the terminal or directly from
your code with:

    binding.irb

*Optional:* If the **binding_of_caller** gem is available, you can just call the `irb`
method and it will start a session with the current binding:

    irb

## Features

### General IRB Improvements

- Syntax highlighting ([wirb](https://github.com/janlelis/wirb/) / [fancy_irb](https://github.com/janlelis/fancy_irb))
- Loads included efficiently to reduce IRB start-up time
- Customizable views for specfic options using [hirb](https://tagaholic.me/2009/03/13/hirb-irb-on-the-good-stuff.html). By default, ActiveRecord results get displayed as a table

### Irbtools' Included Methods for IRB

#### Highlights

- Lookup and manipulate instance variables / methods with ease using [object_shadow](https://github.com/janlelis/object_shadow/)
- Go even further with [looksee](https://github.com/oggy/looksee), the best lookup path inspection tool out there
- Display a method's source code using [code](https://github.com/janlelis/code)
- Find methods that turn one value into another value with [methodfinder](https://github.com/citizen428/methodfinder)
- [Use VIM from inside IRB](https://github.com/jberkel/interactive_editor)

#### Ruby Introspection

Method / Constant | Arguments  | Description | Provided By
------ | ---------- | -----------|-
`code` | object = self, method_name | Display the method source with syntax highlighting. Will also try to look up C methods. | [code](https://github.com/janlelis/code)
`howtocall` | object = self, method_or_proc | Display parameter names and types you will need to call a method | [debugging/howtocall](https://github.com/janlelis/debugging#howtocallobj--self-method_or_proc)
`mf` | object1, object2 | Find methods which turn one value into another value | [methodfinder](https://github.com/citizen428/methodfinder)
`Object#lp` or `Object#look` | | Supercharged method introspection in IRB | [looksee](https://github.com/oggy/looksee)
`Object#shadow` | | Manipulate instance variables and learn about callable methods |  [object_shadow](https://github.com/janlelis/object_shadow/)

#### Platform Info

Method / Constant | Arguments  | Description | Provided By
------ | ---------- | -----------|-
`OS` | | Query operating system information | [os](https://github.com/rdp/os)
`RubyVersion` | | Show the Ruby version | [ruby_version](https://github.com/janlelis/ruby_version)
`RubyEngine` | | Show the Ruby engine | [ruby_engine](https://github.com/janlelis/ruby_engine)
`RubyInfo` | | List general information about the Ruby environment | [ruby_info](https://github.com/janlelis/ruby_info)

#### General Utils

Method / Constant | Arguments  | Description | Provided By
------ | ---------- | -----------|-
`beep` | | Ring terminal bell | [debugging/beep](https://github.com/janlelis/debugging#beep)
`copy` | string | Copy something to the clipboard | [clipboard](https://github.com/janlelis/clipboard)
`colorize` | string | Syntax-highlight a string of Ruby code | [coderay](https://github.com/rubychan/coderay), irbtools
`ed` / `emacs` / `mate` / `mvim` / `nano` / `vi` / `vim` | filename = nil | Start an editor in the session context | [interactive_editor](https://github.com/jberkel/interactive_editor)
`ld` | file | Shortcut for `load lib.to_s + '.rb'` | [every_day_irb](https://github.com/janlelis/every_day_irb)
`pa` | string, color | Print a string in the specified color | [paint](https://github.com/janlelis/paint#utilities)
`page` | what, options = {} | Use pager to improve viewing longer content | [hirb](https://github.com/cldwalker/hirb#pager), irbtools
`paste` | | Paste clipboard content | [clipboard](https://github.com/janlelis/clipboard)
`q` | *args | Like `Kernel#p`, but prints results on one line, with different colors | [debugging/q](https://github.com/janlelis/debugging#qargs)
`re` | string, regexg, groups = nil | Regex debugging helper | [debugging/re](https://github.com/janlelis/debugging#qargs)
`rq` | lib | Shortcut for `require lib.to_s`. Use it like this: `rq:prime` | [every_day_irb](https://github.com/janlelis/every_day_irb)
`rr` | lib | Shortcut for `require_relative lib.to_s` |  [every_day_irb](https://github.com/janlelis/every_day_irb)
`rrq` / `rerequire` | lib | Hack to remove a library from `$LOADED_FEATURES` and `require` it again | [every_day_irb](https://github.com/janlelis/every_day_irb)
`wp` | inspect_string | Syntax-highlight a Ruby return value | [wirb](https://github.com/janlelis/wirb#kernelwp)

#### IRB Support

Method / Constant | Arguments  | Description | Provided By
------ | ---------- | -----------|-
`clear` | | Clear the terminal | [every_day_irb](https://github.com/janlelis/every_day_irb)
`copy_input` | | Copy session history to the clipboard | [clipboard](https://github.com/janlelis/clipboard), irbtools
`copy_output` | | Copy session output history to the clipboard | [clipboard](https://github.com/janlelis/clipboard), irbtools
`reset!` | | Restart the current IRB session | [every_day_irb](https://github.com/janlelis/every_day_irb)
`session_history` | number_of_lines = nil | Return a string of all commands issued in the current session | [every_day_irb](https://github.com/janlelis/every_day_irb)

#### Files and Navigation

Method / Constant | Arguments  | Description | Provided By
------ | ---------- | -----------|-
`cat` | path | Read file contents | [every_day_irb](https://github.com/janlelis/every_day_irb)
`cd` | path = nil | Change the directory. Can also be used in these forms: `~cd` (change to home directory), `-cd` (change to previous directory) | [cd](https://github.com/janlelis/cd)
`chmod` | mode, path | Set file mode for file | [fileutils](https://ruby-doc.org/stdlib/libdoc/fileutils/rdoc/FileUtils.html)
`chmod_R` | mode, path | Set file mode for directory | [fileutils](https://ruby-doc.org/stdlib/libdoc/fileutils/rdoc/FileUtils.html)
`chown` | user, group, path | Set file owner for file | [fileutils](https://ruby-doc.org/stdlib/libdoc/fileutils/rdoc/FileUtils.html)
`chown_R` | user, group, path | Set file owner for directory | [fileutils](https://ruby-doc.org/stdlib/libdoc/fileutils/rdoc/FileUtils.html)
`cp` | source, destination | Copy file | [fileutils](https://ruby-doc.org/stdlib/libdoc/fileutils/rdoc/FileUtils.html)
`cp_r` | source, destination | Copy directory | [fileutils](https://ruby-doc.org/stdlib/libdoc/fileutils/rdoc/FileUtils.html)
`ls` | path = "." | List directory content | [fileutils](https://ruby-doc.org/stdlib/libdoc/fileutils/rdoc/FileUtils.html)
`ln` | target, link | Create symlink (`ln`) | [fileutils](https://ruby-doc.org/stdlib/libdoc/fileutils/rdoc/FileUtils.html)
`ln_s` | target, link | Create symlink (`ln -s`) | [fileutils](https://ruby-doc.org/stdlib/libdoc/fileutils/rdoc/FileUtils.html)
`ln_sf` | target, link | Create symlink (`ln -sf`) | [fileutils](https://ruby-doc.org/stdlib/libdoc/fileutils/rdoc/FileUtils.html)
`mkdir` | path | Create a new directory | [fileutils](https://ruby-doc.org/stdlib/libdoc/fileutils/rdoc/FileUtils.html)
`mkdir_p` | path | Create a new directory (with `-p` option) | [fileutils](https://ruby-doc.org/stdlib/libdoc/fileutils/rdoc/FileUtils.html)
`cp` | source, destination | Move file or directory | [fileutils](https://ruby-doc.org/stdlib/libdoc/fileutils/rdoc/FileUtils.html)
`pwd` | | Return current directory | [fileutils](https://ruby-doc.org/stdlib/libdoc/fileutils/rdoc/FileUtils.html)
`ray` | path | Syntax highlight a Ruby file | [coderay](https://github.com/rubychan/coderay), irbtools
`rm` | path | Delete a file (`rm`) | [fileutils](https://ruby-doc.org/stdlib/libdoc/fileutils/rdoc/FileUtils.html)
`rm_r` | path | Delete a file or directory (`rm -r`) | [fileutils](https://ruby-doc.org/stdlib/libdoc/fileutils/rdoc/FileUtils.html)
`rm_rf` | path | Delete a file or directory, with force (`rm -rf`) | [fileutils](https://ruby-doc.org/stdlib/libdoc/fileutils/rdoc/FileUtils.html)
`rmdir` | path | Delete an empty directory | [fileutils](https://ruby-doc.org/stdlib/libdoc/fileutils/rdoc/FileUtils.html)

### IRB's ls?

Please note that IRB's own **ls** command is aliased to `ils`, since `ls` referts to FileUtils' method for listing the current files in the directory.

### Advanced Tweaking

See [CONFIGURE.md](https://github.com/janlelis/irbtools/blob/master/CONFIGURE.md).

### Troubleshooting: ANSI colors on Windows

Windows: ANSI support can be enabled via
[ansicon](https://github.com/adoxa/ansicon) or
[ConEmu](https://conemu.github.io/) or
[WSL](https://docs.microsoft.com/en-us/windows/wsl/about).

### Troubleshooting: Clipboard not working on Linux

Clipboard support requires **xsel** or **xclip**. On ubuntu, do:

    sudo apt-get install xsel

### Hint: Debundle

If you do not want to add **Irbtools** to your project's `Gemfile`, you will need a
[debundle hack](https://github.com/janlelis/debundle.rb). Put it at the
beginning of your `~/.irbrc` file and you are fine.

### Hint: No ANSI / IRB extension

You can use **Irbtools** without colors/IRB extensions. To do so, put this into `~/.irbrc`:

```ruby
require 'irbtools/non_fancy'
Irbtools.start
```

### Hint: Web Console and Other Approaches

**Irbtools** works well together with the amazing [web-console!](https://github.com/rails/web-console), and also with the [ripl](https://github.com/cldwalker/ripl) IRB alternative.

## J-_-L

Copyright (c) 2010-2022 Jan Lelis <https://janlelis.com> released under the MIT
license.
