# Irbtools [![version](https://badge.fury.io/rb/irbtools.svg)](https://badge.fury.io/rb/irbtools) [![[travis]](https://travis-ci.org/janlelis/irbtools.svg)](https://travis-ci.org/janlelis/irbtools)

```ruby
                                                                                 _|          _|
 _|_|_|  _|_|_|    _|_|_|        _|                          _|                _|    _|_|_|    _|
   _|    _|    _|  _|    _|    _|_|_|_|    _|_|      _|_|    _|    _|_|_|      _|          _|  _|
   _|    _|_|_|    _|_|_|        _|      _|    _|  _|    _|  _|  _|_|          _|      _|_|    _|
   _|    _|    _|  _|    _|      _|      _|    _|  _|    _|  _|      _|_|      _|          _|  _|
 _|_|_|  _|    _|  _|_|_|    _|    _|_|    _|_|      _|_|    _|  _|_|_|        _|    _|_|_|    _|
                                                                                 _|          _|
```

Improvements for Ruby's IRB console, like syntax highlighted output and a lot of
debugging and introspection methods. Unlike with PRY, you are still in your
normal IRB. It is designed to work out-of-the-box, so there is no reason to not
use it!

## Setup

    $ gem install irbtools

IRB executes code in `~/.irbrc` on start-up. If the file does not exist, yet,
just create a new one. Add the following content:

    require 'irbtools'

You also need to add irbtools to your project's `Gemfile`:

    gem 'irbtools', require: 'irbtools/binding'

Then start IRB (with **Irbtools** loaded) from the terminal or directly from your code with:

    binding.irb

### More Improvements

Some suggested gems will not be installed to ensure wider general support. For
the full feature set, you can install **irbtools-more**. To do so, change your
`.irbrc` to:

    require 'irbtools/more'

and edit your `Gemfile` to read like this:

    gem 'irbtools-more', require: 'irbtools/binding'

### Included Gems and Libraries
#### IRB Improvements

*   Colored output:
    [wirb](https://github.com/janlelis/wirb/) /
    [fancy_irb](https://github.com/janlelis/fancy_irb)
*   Custom views for specific objects:
    [hirb](https://tagaholic.me/2009/03/13/hirb-irb-on-the-good-stuff.html)
*   **(irbtools-more)** Better tab-completion:
    [bond](https://tagaholic.me/bond/)

#### Utils

*   Useful IRB commands (listed in next section):
    [every_day_irb](https://github.com/janlelis/every_day_irb) /
    [debugging](https://github.com/janlelis/debugging) /
    [fileutils](https://ruby-doc.org/stdlib/libdoc/fileutils/rdoc/FileUtils.html)
*   Clipboard Access:
    [clipboard](https://github.com/janlelis/clipboard)
*   Terminal colors:
    [paint](https://github.com/janlelis/paint)
*   Load an editor into your IRB session:
    [interactive_editor](https://github.com/jberkel/interactive_editor)

#### Introspection

*   Lookup and manipulate instance variables / methods with ease:
    [object_shadow](https://github.com/janlelis/object_shadow/)
*   **(irbtools-more)** Make lookup path inspection even more awesome:
    [looksee](https://github.com/oggy/looksee)
*   Display a method's source code:
    [code](https://github.com/janlelis/code)
*   Find methods that turn one value into another value:
    [methodfinder](https://github.com/citizen428/methodfinder)
*   Access the *ri* docs:
    [ori](https://github.com/dadooda/ori)
*   Platform information:
    [ruby_version](https://github.com/janlelis/ruby_version) /
    [ruby_engine](https://github.com/janlelis/ruby_engine) /
    [os](https://github.com/rdp/os) /
    [ruby_info](https://github.com/janlelis/ruby_info)

### Irbtools Methods

Besides configuring IRB itself, and loading all libraries efficiently, **Irbtools** provides the following methods:

#### Ruby Introspection

Method / Constant | Arguments  | Description
------ | ---------- | -----------
`code` | object = self, method_name | Display the method source with syntax highlighting. Will also look up C methods if the **core_docs** gem (which is included in **irbtools-more**) is available.
`howtocall` | object = self, method_or_proc | Displays parameter names and types for a proc or method.
`mf` | object1, object2 | Find methods that turn one value into another value.
`mof` | object, depth = 0, grep = // | Print a method list, ordered by modules.
`Object#lp` | | **(irbtools-more)** Supercharged method introspection in IRB.
`Object#ri` | *args | Show ri documentation for this object or method.
`Object#shadow` | | Proxy object for manipulating instance variables and method introspection.

#### Platform Info

Method / Constant | Arguments  | Description
------ | ---------- | -----------
`OS` | | Query operating system information.
`RubyVersion` | | Show the Ruby version.
`RubyEngine` | | Show the Ruby engine.
`RubyInfo` | | List general information about the Ruby environment.

#### General Utils

Method / Constant | Arguments  | Description
------ | ---------- | -----------
`beep` | | Ring terminal bell.
`copy` | string | Copy something to the clipboard.
`colorize` | string | Syntax-highlight a string of Ruby code.
`ed` / `emacs` / `mate` / `mvim` / `nano` / `vi` / `vim` | filename = nil | Start an editor in the session context.
`ld` | file | Shortcut for `load lib.to_s + '.rb'`.
`pa` | string, color | Print a string in the specified color.
`page` | what, options = {} | Use pager to improve viewing longer content
`paste` | | Paste clipboard content.
`q` | *args | Like `Kernel#p`, but prints results on one line, with different colors.
`re` | string, regexg, groups = nil | Assists you when matching regexes againts strings.
`rq` | lib | Shortcut for `require lib.to_s`. Use it like this: `rq:prime`.
`rr` | lib | Shortcut for `require_relative lib.to_s`.
`rrq` / `rerequire` | lib | Hack to remove a library from `$LOADED_FEATURES` and `require` it again.
`wp` | inspect_string | Syntax-highlight a Ruby return value.

#### IRB Support

Method / Constant | Arguments  | Description
------ | ---------- | -----------
`clear` | | Clear the terminal.
`copy_input` | | Copy session history to the clipboard.
`copy_output` | | Copy session output history to the clipboard.
`reset!` | | Restart the current IRB session.
`session_history` | number_of_lines = nil | Return a string of all commands issued in the current session.

#### Files and Navigation

Method / Constant | Arguments  | Description
------ | ---------- | -----------
`cat` | path | Read file contents
`cd` | path = nil | Change the directory. Can also be used in these forms: `~cd` (change to home directory), `-cd` (change to previous directory).
`chmod` | mode, path | Set file mode for file
`chmod_R` | mode, path | Set file mode for directory
`chown` | user, group, path | Set file owner for file
`chown_R` | user, group, path | Set file owner for directory
`cp` | source, destination | Copy file
`cp_r` | source, destination | Copy directory
`ls` | path = "." | List directory content
`ln` | target, link | Create symlink (`ln`)
`ln_s` | target, link | Create symlink (`ln -s`)
`ln_sf` | target, link | Create symlink (`ln -sf`)
`mkdir` | path | Create a new directory
`mkdir_p` | path | Create a new directory (with `-p` option)
`cp` | source, destination | Move file or directory
`pwd` | | Return current directory
`ray` | path | Syntax highlight a Ruby file
`rm` | path | Delete an a file (`rm`)
`rm_r` | path | Delete an a file or directory (`rm -r`)
`rm_rf` | path | Delete an a file or directory, with force (`rm -rf`)
`rmdir` | path | Delete an empty directory

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

### Hint: Web Console

**Irbtools** works well together with the amazing
[web-console!](https://github.com/rails/web-console)

## J-_-L

Copyright (c) 2010-2019 Jan Lelis <https://janlelis.com> released under the MIT
license.
