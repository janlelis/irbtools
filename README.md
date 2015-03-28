# Irbtools [![version](https://badge.fury.io/rb/irbtools.svg)](http://badge.fury.io/rb/irbtools)

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

*   Colorization: [wirb](https://github.com/janlelis/wirb/)
*   IRB tweaks: [fancy_irb](https://github.com/janlelis/fancy_irb)
*   Custom views for specific objects:
    [hirb](http://tagaholic.me/2009/03/13/hirb-irb-on-the-good-stuff.html)
*   **(irbtools-more)** Correction for misspelled method/constant names:
    [bond](https://github.com/yuki24/did_you_mean)
*   **(irbtools-more)** Better IRB tab-completion:
    [bond](http://tagaholic.me/bond/)

#### Helpful Methods

*   Useful IRB commands:
    [every_day_irb](https://github.com/janlelis/irbtools/tree/master/lib/every
    _day_irb.rb)
*   Clipboard Access: [clipboard](http://github.com/janlelis/clipboard)
*   Loads an editor into your IRB session:
    [interactive_editor](https://github.com/jberkel/interactive_editor)
*   Print debugging helpers: [debugging](https:/github.com/janlelis/debugging)
*   File-related system commands: **fileutils** (stdlib)


#### Platform Information

*   Query current Ruby version:
    [ruby_version](https://github.com/janlelis/ruby_version)
*   Query current Ruby engine:
    [ruby_engine](https://github.com/janlelis/ruby_engine)
*   Query current operating system: [os](https://github.com/rdp/os)
*   Global information by the interpreter behind one `Info` constant:
    [ruby_info](https://github.com/janlelis/ruby_info)


#### Introspection

*   Improved lookup path inspection:
    [method_locator](https://github.com/ryanlecompte/method_locator)
*   Displays a method's source:
    [method_source](https://github.com/banister/method_source)
*   Adds a `ri` doc method to Object: [[ori](https://github.com/dadooda/ori)
*   Finds the methods that turned a value into another value:
    [methodfinder](https://github.com/citizen428/methodfinder)
*   Syntax highlighting: [coderay](https://github.com/rubychan/coderay)
*   **irbtools-more** Awesome lookup path inspection:
    [looksee](https://github.com/oggy/looksee)


### Irbtools Methods
#### From every_day_irb

ls
:   Returns an array with the directory's content
cat
:   Shortcut for `File.read`
rq
:   Shortcut for `require library.to_s` (allows concise syntax like
    `rq:mathn`)
ld
:   Shortcut for `load library.to_s + '.rb'`
rrq/rerequire
:   Little hack for rerequiring a library (it's really hack and not reliable,
    but works in most cases)
reset!
:   Restarts IRB
clear
:   Clears the terminal (`system "clear"`)
session_history
:   Returns all issued commands as a string


#### From irbtools in conjunction with the libraries

cd
:   Improves the cd that is already provided by **fileutils** (try `cd '-'`)
version
:   Displays RubyVersion
engine
:   Displays RubyEngine
os
:   OS information
info
:   Aggregates information about your Ruby environment
copy
:   Shortcut for `Clipboard.copy`
paste
:   Shortcut for `Clipboard.paste`
copy_input
:   Copies the session_history to the clipboard
copy_output
:   Copies this session's results to the clipboard
mf
:   Shortcut for using the **methodfinder**
page
:   Shortcut for using the pager from **hirb**
colorize
:   Syntax highlights a ruby string using **coderay**
ray
:   Syntax highlights a ruby file using **coderay**


#### From the libraries (puplic Object methods, renamed/patched)

ri
:   Patching the `ri` provided by **ori** to also allow default ri syntax on
    toplevel
src
:   Shortcut for displaying the method source using **method_source** and
    **coderay**
mlp
:   Shortcut for the **method_locator**
l/lp
:   Alternative method name to trigger the **looksee** gem (**irbtools-more**)


## Advanced tweaking

See [CONFIGURE.md](https://github.com/janlelis/irbtools/blob/master/CONFIGURE.md)


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


## Hint: Web Console

**irbtools** works well together with the amazing
[web-console!](https://github.com/rails/web-console)


## J-_-L

Copyright (c) 2010-2015 Jan Lelis <http://janlelis.com> released under the MIT
license.
