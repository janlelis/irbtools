# Irbtools [![version](https://badge.fury.io/rb/irbtools.svg)](http://badge.fury.io/rb/irbtools)

Improvements for Ruby's IRB console, for example, colored output, and a lot of
debugging and introspection methods. Unlike with PRY, you are still in your
normal IRB. It is designed to work out-of-the-box so there is no reason to not
use it!

## Setup

    $ gem install irbtools

IRB executes code in `~/.irbrc` on start-up. If the file does not exist, yet,
just create a new one. Add the following content:

    require 'irbtools'

You also need to add irbtools to your project's Gemfile:

    gem 'irbtools', require: 'irbtools/binding'

Then start IRB (with **irbtools**) directly from your code with:

    binding.irb

If the `binding_of_caller` gem is available (e.g. see below), you can omit the `binding`:

    irb

### More improvements

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


#### Code Organization

*   Shortcuts for your favorite methods, saved in personal yaml file:
    [alias](http://tagaholic.me/2009/07/07/alias-quickness-in-the-ruby-console
    .html)


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
### Welcome Message

The welcome message can be customized with `Irbtools.welcome_message=`

### Customize libraries to load

It is possible to modify, which libraries to load:

    # Don't require 'irbtools', but:
    require 'irbtools/configure'
    # Here you can modify the libraries using the methods below
    Irbtools.start

If you do not want to load the default set of **irbtools** gems, you will have
to use `require 'irbtools/minimal'` instead of `configure`.

You can use the following methods:

*   `Irbtools.add_library(lib, options_hash, &block)`
*   `Irbtools.remove_library(lib)`


The `options_hash` defines the way in which **irbtools** loads the library.
The following options are possible
(no options)/`:start`
:   The library is required on startup before doing anything else (before
    displaying the prompt)
`:thread => identifier`
:   After loading everything else, the library is required in a thread (while
    continuing loading). You can choose any identifier, but if you take the
    same one for multiple libraries, they will be loaded in the same thread
    (in the order that you define)
`:late => true`
:   The library is required just before showing the prompt (note: loading
    threads might still be in process)
`:late_thread => identifier`
:   Same as `:thread`, but after loading late libraries.
`:sub_session => true`
:   The library is loaded every time a sub-session starts (using
    `IRB.conf[:IRB_RC]`). In [ripl](https://github.com/cldwalker/ripl),
    `ripl-after_rc` is used.
`:autoload => :Constant`
:   Use Ruby's `autoload` feature. It loads the library as soon as the
    constant is encountered.


You can pass a block as third argument, which gets executed after the library
has completed loading (except for `:autoload`, in which case the code will be
executed directly on startup). You can modify the callbacks by using
`Irbtools.add_library_callback` and `Irbtools.replace_library_callback`.

When adding a new library, you should firstly consider some way to load it via
`:autoload`. If this is not possible, try loading via `:thread`. If that is
not possible either, you will need to fallback to the default loading
mechanism.

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

## Hint: Faster start-up

You can get an about a second faster start-up time by changing the loading
methods for wirb and fancy_irb to `:thread` (drawback: the hash rocket will
not be used for the first result):

    require 'irbtools/configure'
    Irbtools.remove_library :paint
    Irbtools.remove_library :fancy_irb
    Irbtools.add_library :paint, :late => true do Wirb.load_schema :classic_paint if defined? Wirb end
    Irbtools.add_library :fancy_irb, :thread => -1 do FancyIrb.start end
    Irbtools.start

## Hint: Web Console

**irbtools** works well together with the amazing
[web-console!](https://github.com/rails/web-console)

## J-_-L

Copyright (c) 2010-2015 Jan Lelis <http://janlelis.com> released under the MIT
license.
