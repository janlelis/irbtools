# Irbtools [![version](https://badge.fury.io/rb/irbtools.svg)](http://badge.fury.io/rb/irbtools)

     _ _|        |      |                  |
       |    __|  __ \   __|   _ \    _ \   |   __|
       |   |     |   |  |    (   |  (   |  | \__ \
     ___| _|    _.__/  \__| \___/  \___/  _| ____/


Improvements for Ruby's IRB console, like colored output and a lot of
debugging and introspection methods. Unlike with PRY, you are still in your
normal IRB. It is designed to work out-of-the-box, so there is no reason to not
use it!

## Setup

    $ gem install irbtools

IRB executes code in `~/.irbrc` on start-up. If the file does not exist, yet,
just create a new one. Add the following content:

    require 'irbtools'

You also need to add irbtools to your project's Gemfile:

    gem 'irbtools', require: 'irbtools/binding'

Then start IRB (with **irbtools** loaded) from the console or directly from your code with:

    binding.irb

If the `binding_of_caller` gem is available (e.g. see below), you can omit the `binding`:

    irb

### More Improvements

Some suggested gems will not be installed to ensure wider general support. For
the full feature set, you can add
[irbtools-more](https://github.com/janlelis/irbtools-more) and change your
`.irbrc` to:

    require 'irbtools/more'

and edit your Gemfile to

    gem 'irbtools-more', require: 'irbtools/binding'


### Included Gems and Libraries
#### IRB Improvements

*   Colored output:
    [wirb](https://github.com/janlelis/wirb/)
    [fanycy_irb](https://github.com/janlelis/fancy_irb)
*   Custom views for specific objects:
    [hirb](http://tagaholic.me/2009/03/13/hirb-irb-on-the-good-stuff.html)
*   **(irbtools-more)** Correction suggestions for misspelled method/constant names:
    [did_you_mean](https://github.com/yuki24/did_you_mean)
*   **(irbtools-more)** Better tab-completion:
    [bond](http://tagaholic.me/bond/)

#### Utils

*   Useful IRB commands (see below):
    [every_day_irb](https://github.com/janlelis/irbtools/tree/master/lib/every
    _day_irb.rb)
    [debugging](https:/github.com/janlelis/debugging)
    [fileutils](http://ruby-doc.org/stdlib-2.2.1/libdoc/fileutils/rdoc/FileUtils.html)
*   Clipboard Access:
    [clipboard](https://github.com/janlelis/clipboard)
*   Terminal colors:
    [paint](https://github.com/janlelis/paint)
*   Load an editor into your IRB session:
    [interactive_editor](https://github.com/jberkel/interactive_editor)

#### Introspection

*   Displays a method's source:
    [code](https://github.com/janlelis/code)
*   Access to `ri` docs:
    [ori](https://github.com/dadooda/ori)
*   Manipulate instance variables with ease:
    [instance](https://github.com/rubyworks/instance/)
*   Platform information:
    [ruby_version](https://github.com/janlelis/ruby_version)
    [ruby_engine](https://github.com/janlelis/ruby_engine)
    [os](https://github.com/rdp/os)
    [ruby_info](https://github.com/janlelis/ruby_info)
*   Improved method lookup path inspection:
    [method_locator](https://github.com/ryanlecompte/method_locator)
*   Finds methods that turn one value into another value:
    [methodfinder](https://github.com/citizen428/methodfinder)
*   **irbtools-more** Awesome lookup path inspection:
    [looksee](https://github.com/oggy/looksee)


### Irbtools Methods

Besides improving IRB itself, you will get the following methods:

Method | Arguments  | Description
------ | ---------- | -----------
`beep` | | Ring terminal bell.
`cat` | path | Read file contents.
`cd` | path = nil | Changes the directory. Can also be used in these forms: `~cd` (change to home directory), `-cd` (change to previous directory).
`clear` | | Clear the terminal.
`code` | object = self, method_name | Display the method source with syntax highlighting. Will also look up C methods if the **core_docs** gem is available.
`colorize` | string | Syntax highlight a Ruby string.
`copy` | string | Copy something to the clipboard.
`copy_input` | | Copy session history to the clipboard.
`copy_output` | | Copy session output history to the clipboard.
`ed` / `emacs` / `mate` / `mvim` / `nano` / `vi` / `vim` | filename = nil | Start an editor in the session context.
`engine` | | Show the Ruby engine.
`g` | *args | Like `Kernel#p`, but using terminal-notifier or growl.
`howtocall` | object = self, method_or_proc | Displays parameter names and types for a proc or method.
`info` | | List general information about the Ruby environment.
`ld` | file | Shortcut for `load lib.to_s + '.rb'`.
`ls` | path = "." | List directory content.
`mf` | object1, object2 | Find methods that turn one value into another value:w
`mof` | object, depth = 0, grep = // | Print a method list, ordered by modules.
`os` | | Query operating system information.
`pa` | string, color | Print a string in the specified color.
`page` | what, options = {} | Page long content.
`paste` | | Paste clipboard content.
`q` | *args | Like `Kernel#p`, but prints results on one line, with different colors.
`ray` | path | Syntax highlight a Ruby file.
`re` | string, regexg, groups = nil | Assists you when matching regexes againts strings.
`reset!` | | Restart the current IRB session.
`rq` | lib | Shortcut for `require lib.to_s`. Use it like this: `rq:prime`.
`rrq` / `rerequire` | lib | Hack to remove a library from `$LOADED_FEATURES` and `require` it again.
`session_history` | number_of_lines = nil | Return a string of all commands issued in the current session.
`version` | | Show the Ruby version.
`wp` | inspect_string | Syntax-highlight a Ruby object.
`Object#instance` | | Proxy object to read and manipulate instance variables / run eval.
`Object#lp | | **Only with irbtools-more** Supercharged method introspection in IRB
`Object#mlp` / `Object#method_lookup_path` | | Traverse an object's method lookup path to find all places where a method may be defined.
`Object#ri` | *args | Show ri documentation for this object or method.


## Advanced tweaking

See [CONFIGURE.md](https://github.com/janlelis/irbtools/blob/master/CONFIGURE.md).


## Troubleshooting: ANSI colors on Windows

Windows: ANSI support can be enabled via
[ansicon](https://github.com/adoxa/ansicon) or
[ConEmu](http://code.google.com/p/conemu-maximus5/).


## Troubleshooting: Clipboard not working on Linux

Clipboard support requires **xclip** or **xsel**. On ubuntu, do: `sudo apt-get
install xclip`


## Troubleshooting: Unicode causes wrong display widths

If you use double-width unicode characterss, you will need to paste the
following snippet to your `.irbrc` file.

    Irbtools.replace_library_callback :fancy_irb do
      FancyIrb.start east_asian_width: true
    end

This setting is deactivated by default, because of performance issues.


## Hint: Debundle

If you do not want to add irbtools to your project's Gemfile, you will need a
[debundle hack](https://github.com/janlelis/debundle.rb). Put it at the
beginning of your `~/.irbrc` file and you are fine (until it breaks).


## Hint: No ANSI / IRB extension

You can use irbtools without colors/irb extensions. To do so, put this into `~/.irbrc`:

```ruby
require 'irbtools/non_fancy'
Irbtools.start
```


## Hint: Web Console

**irbtools** works well together with the amazing
[web-console!](https://github.com/rails/web-console)


## J-_-L

Copyright (c) 2010-2015 Jan Lelis <http://janlelis.com> released under the MIT
license.
