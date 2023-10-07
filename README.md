# Irbtools [![[version]](https://badge.fury.io/rb/irbtools.svg)](https://badge.fury.io/rb/irbtools)  [![[ci]](https://github.com/janlelis/irbtools/workflows/Test/badge.svg)](https://github.com/janlelis/irbtools/actions?query=workflow%3ATest)

## Irbtools 4.0 for IRB 1.8+

The current version of Irbtools requires [IRB 1.8+](https://github.com/ruby/irb) (which is the default for Ruby
from 3.2 on). Please use Irbtools 3 for earlier versions of IRB.

## Description

Improves Ruby's IRB with:

- a default configuration
- improved syntax highlighting of result objects
- helpful commands for debugging and introspection

## Examples

### Show lookup chain and method list grouped by visibility

```ruby
>> shadow [1,2,3].reverse
=> # ObjectShadow of Object #85280

## Lookup Chain

    [#<Class:#<Array:0x00007fccd9cfac30>>, Array, Enumerable, Object, "…"]

## 141 Public Methods (Non-Class/Object)

    [:&, :*, :+, :-, :<<, :<=>, :==, :[], :[]=, :all?, :any?, :append, :assoc, :at, :bsearch, :bsearch_index, :chain,
    :chunk, :chunk_while, :clear, :collect, :collect!, :collect_concat, :combination, :compact, :compact!, :concat,
    :count, :cycle, :deconstruct, :delete, :delete_at, :delete_if, :detect, :difference, :dig, :drop, :drop_while,
    :each, :each_cons, :each_entry, :each_index, :each_slice, :each_with_index, :each_with_object, :empty?, :entries,
    :eql?, :fetch, :fill, :filter, :filter!, :filter_map, :find, :find_all, :find_index, :first, :flat_map, :flatten,
    :flatten!, :grep, :grep_v, :group_by, :hash, :include?, :index, :inject, :insert, :inspect, :intersect?,
    :intersection, :join, :keep_if, :last, :lazy, :length, :map, :map!, :max, :max_by, :member?, :min, :min_by,
    :minmax, :minmax_by, :none?, :one?, :pack, :partition, :permutation, :pop, :prepend, :product, :push, :rassoc,
    :reduce, :reject, :reject!, :repeated_combination, :repeated_permutation, :replace, :reverse, :reverse!,
    :reverse_each, :rindex, :rotate, :rotate!, :sample, :select, :select!, :shelljoin, :shift, :shuffle, :shuffle!,
    :size, :slice, :slice!, :slice_after, :slice_before, :slice_when, :sort, :sort!, :sort_by, :sort_by!, :sum,
    :take, :take_while, :tally, :to_a, :to_ary, :to_h, :to_s, :to_set, :transpose, :union, :uniq, :uniq!, :unshift,
    :values_at, :zip, :|]

## 2 Private Methods (Non-Class/Object)

    [:initialize, :initialize_copy]

## Object Inspect

    [3, 2, 1]
```

### Show a method list grouped by ancestors

```ruby
>> look "str"
.
.
.
Comparable
  <  <=  ==  >  >=  between?  clamp
String
  %            crypt                  inspect      squeeze!
  *            dedup                  intern       start_with?
  +            delete                 length       strip
  +@           delete!                lines        strip!
  -@           delete_prefix          ljust        sub
  <<           delete_prefix!         lstrip       sub!
  <=>          delete_suffix          lstrip!      succ
.
.
.
```

### Show source code of a Ruby-based method

```ruby
>> code SecureRandom.uuid
#
#   /home/dan/.rvm/rubies/ruby-3.2.0/lib/ruby/3.2.0/random/formatter.rb:170
#
# Generate a random v4 UUID (Universally Unique IDentifier).
#
#   require 'random/formatter'
#
#   Random.uuid #=> "2d931510-d99f-494a-8c67-87feb05e1594"
#   Random.uuid #=> "bad85eb9-0713-4da7-8d36-07a8e4b00eab"
#   # or
#   prng = Random.new
#   prng.uuid #=> "62936e70-1815-439b-bf89-8492855a7e6b"
#
# The version 4 UUID is purely random (except the version).
# It doesn't contain meaningful information such as MAC addresses, timestamps, etc.
#
# The result contains 122 random bits (15.25 random bytes).
#
# See RFC4122[https://datatracker.ietf.org/doc/html/rfc4122] for details of UUID.
#
def uuid
  ary = random_bytes(16).unpack("NnnnnN")
  ary[2] = (ary[2] & 0x0fff) | 0x4000
  ary[3] = (ary[3] & 0x3fff) | 0x8000
  "%08x-%04x-%04x-%04x-%04x%08x" % ary
end
```

### Show source code of a natively implemented method

```ruby
>> code Array#reverse
//
//   https://github.com/ruby/ruby/blob/ruby_3_2/array.c#L3282
//
// Returns a new \Array with the elements of +self+ in reverse order:
//
//   a = ['foo', 'bar', 'two']
//   a1 = a.reverse
//   a1 # => ["two", "bar", "foo"]
static VALUE
rb_ary_reverse_m(VALUE ary)
{
    long len = RARRAY_LEN(ary);
    VALUE dup = rb_ary_new2(len);

    if (len > 0) {
        const VALUE *p1 = RARRAY_CONST_PTR_TRANSIENT(ary);
        VALUE *p2 = (VALUE *)RARRAY_CONST_PTR_TRANSIENT(dup) + len - 1;
        do *p2-- = *p1++; while (--len > 0);
    }
    ARY_SET_LEN(dup, RARRAY_LEN(ary));
    return dup;
}
```

### Find out method signatures (most useful for Ruby-based methods with keyword args)

```ruby
>> howtocall require
require(path)
```

```ruby
>> require "rubygems/user_interaction"
>> ui = Gem::ConsoleUI.new
>> howtocall ui.choose_from_list
choose_from_list(question, list)
```

### Call system commands with `$`

```ruby
>> $ git status # displays current git status
```

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
- Loads included libraries efficiently to reduce IRB start-up time
- Customizable views for specfic options using [hirb](https://tagaholic.me/2009/03/13/hirb-irb-on-the-good-stuff.html). By default, ActiveRecord results get displayed as a table.

### Included Debugging Methods for IRB

#### Highlights

- Lookup and manipulate instance variables / methods with ease using [object_shadow](https://github.com/janlelis/object_shadow/)
- Go even further with [looksee](https://github.com/oggy/looksee), the best lookup path inspection tool out there
- Display a method's source code using [code](https://github.com/janlelis/code)
- Find methods that turn one value into another value with [methodfinder](https://github.com/citizen428/methodfinder)
- [Use VIM from inside IRB](https://github.com/jberkel/interactive_editor)

#### Extra Commands

Commands get treated specially by IRB and do not necessarily follow Ruby syntax.

Command | Alias | Description | Example
------ | ---------- | ---------|---
`code ` | - | Shows syntax-highlighted source code of a method | `code Array#reverse`
`howtocall ` | - | Shows the method signature | `howtocall String#gsub`
`look ` | - | Shows looksee method list | `look [1,2,3]`
`shadow ` | `+ ` | Shows object shadow method list | `shadow [1,2,3]`
`sys ` | `$ ` | Calls system shell | `$ top`

Two default commands have an additional alias:

Command | Alias | Description | Example
------ | ---------- | ---------|---
`show_doc` | `ri ` | Shows documentation | `ri String#gsub`
`chws` | `co ` | "change into an object" | `co [1,2,3]`

##### IRB's ls?

Please note that IRB's own **ls** command is aliased to `ils`, since `ls` already refers to a method listing all files in the current directory. If you haven't tried looksee (`look`) or object shadows (`shadow`) - give it a try ;)

#### Ruby Introspection

Method / Constant | Arguments  | Description | Provided By
------ | ---------- | -----------|-
`Object#lp` or `Object#look` | | Supercharged method introspection in IRB | [looksee](https://github.com/oggy/looksee)
`Object#shadow` | | Manipulate instance variables and learn about callable methods |  [object_shadow](https://github.com/janlelis/object_shadow/)
`code` | object = self, method_name | Display the method source with syntax highlighting. Will also try to look up C methods. | [code](https://github.com/janlelis/code)
`howtocall` | object = self, method_or_proc | Display parameter names and types you will need to call a method | [debugging/howtocall](https://github.com/janlelis/debugging#howtocallobj--self-method_or_proc)
`mf` | object1, object2 | Find methods which turn one value into another value | [methodfinder](https://github.com/citizen428/methodfinder)

#### Platform Info

Method / Constant | Arguments  | Description | Provided By
------ | ---------- | -----------|-
`OS` | | Query operating system information | [os](https://github.com/rdp/os)
`RubyVersion` | | Show the Ruby version | [ruby_version](https://github.com/janlelis/ruby_version)
`RubyEngine` | | Show the Ruby engine | [ruby_engine](https://github.com/janlelis/ruby_engine)

#### General Utils

Method / Constant | Arguments  | Description | Provided By
------ | ---------- | -----------|-
`beep` | | Ring terminal bell | [debugging/beep](https://github.com/janlelis/debugging#beep)
`clear` | | Clear the terminal | [every_day_irb](https://github.com/janlelis/every_day_irb)
`copy` | string | Copy something to the clipboard | [clipboard](https://github.com/janlelis/clipboard)
`copy_output` | | Copy session output history to the clipboard | [clipboard](https://github.com/janlelis/clipboard), irbtools
`colorize` | string | Syntax-highlight a string of Ruby code | [coderay](https://github.com/rubychan/coderay), irbtools
`ed` / `emacs` / `mate` / `mvim` / `nano` / `vi` / `vim` | filename = nil | Start an editor in the session context | [interactive_editor](https://github.com/jberkel/interactive_editor)
`ld` | file | Shortcut for `load lib.to_s + '.rb'` | [every_day_irb](https://github.com/janlelis/every_day_irb)
`pa` | string, color | Print a string in the specified color | [paint](https://github.com/janlelis/paint#utilities)
`page` | what, options = {} | Use pager to improve viewing longer content | [hirb](https://github.com/cldwalker/hirb#pager), irbtools
`paste` | | Paste clipboard content | [clipboard](https://github.com/janlelis/clipboard)
`q` | *args | Like `Kernel#p`, but prints results on one line, with different colors | [debugging/q](https://github.com/janlelis/debugging#qargs)
`re` | string, regexg, groups = nil | Regex debugging helper | [debugging/re](https://github.com/janlelis/debugging#qargs)
`reset!` | | Restart the current IRB session | [every_day_irb](https://github.com/janlelis/every_day_irb)
`rq` | lib | Shortcut for `require lib.to_s`. Use it like this: `rq:prime` | [every_day_irb](https://github.com/janlelis/every_day_irb)
`rr` | lib | Shortcut for `require_relative lib.to_s` |  [every_day_irb](https://github.com/janlelis/every_day_irb)
`rrq` / `rerequire` | lib | Hack to remove a library from `$LOADED_FEATURES` and `require` it again | [every_day_irb](https://github.com/janlelis/every_day_irb)
`wp` | inspect_string | Syntax-highlight a Ruby return value | [wirb](https://github.com/janlelis/wirb#kernelwp)

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
`ls` | path = "." | List directory content | [cd](https://github.com/janlelis/cd)
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
## J-_-L

Copyright (c) 2010-2023 Jan Lelis <https://janlelis.com> released under the MIT
license.
