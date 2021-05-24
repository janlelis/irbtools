# Irbtools Changelog

## 3.0.5
* Bump methodfinder dependency & update usage (fixes #52)

## 3.0.4
* Loosen Ruby dependency to allow Ruby 3.0

## 3.0.3
* Workaround a HIRB issue for newer IRBs (fixes #48)
* Workaround ORI issue for newer IRBs

## 3.0.2
* Bump wirb to ensure Ruby 2.7 compatibility

## 3.0.1
* Bump fancy_irb to ensure Ruby 2.7 compatiblity

## 3.0.0
* Make IRB itself a dependency (default gem)
* Move: "Every day… IRB" into its own git repository
  * https://github.com/janlelis/every_day_irb
* Replace instance and method_locator gems with new object_shadow gem
* Improve README
* Version bump code, clipboard, and methodfinder

## 2.2.2
* Remove Rails WIRB loading hack (no longer necessary)

## 2.2.1
* Allow os gem to be below 1.0
* Do not use binding.repl gem if Ruby version is at least 2.5

## 2.2.0
* Remove info, version, engine, and os methods. Use RubyInfo, RubyVersion, RubyEngine, and OS instead (fixes #40)

## 2.1.0
* Improve Rails compatibility
  * Do not load instance gem in the context of Rails
  * Make sure to actually require "irb" before using it
  * Use terrible hack to load Wirb in context of Rails
* Relax paint dependency (allows usage of paint >= 2.0)
* Require new versions of fancy_irb, clipboard, os
* Set abort_on_exception to true for late threads (early threads do this implicitly via join)

## 2.0.1
* Remove g gem

## 2.0.0
* Use Wirb 2.0 and FancyIrb 1.0
* Drop support for Ruby 1
* Simplify starting from code via: require 'irbtools/binding'
* Rename method to show a method's source to: code
* Add instance gem
* Remove code organization gems (boson + alias)
* Don't add '.' to the load path, use rr (require_relative) instead
* Improve loading order of libraries
* Remove aliases for Irbtools configuration
* Integrate irbtools-more into irbtools main repo
* EveryDayIrb now gets released on its own, instead with every new irbtools version
* Improve documentation in Readme

## 1.7.1
* bump binding.repl, hirb, methodfinder

## 1.7.0
* bump boson, boson-more, binding.repl
* required ruby version: 1.9.3
* remove awesome_print

## 1.6.1
* don't load debugging/repl by default
* rename re method to engine and rv to version

## 1.6.0
* remove zucker dependency, but add debugging, ruby_version, ruby_engine, ruby_info and os gem
* configure binding.repl to load irb, not pry
* bump binding.repl, paint, wirb

## 1.5.1
* include binding.repl gem
* bump coderay, awesome_print, method_source, wirb

## 1.5.0
* update debundle hack
* load less zucker libraries
* add alias gem
* finaly load boson correctly (but don't load any boson plugin, yet), also depend on boson-more
* version bumps (zucker, clipboard, paint, hirb, wirb, ap, coderay, g)

## 1.4.0
* every_day_irb is now a module that extends self
* specs for most of every_day_irb's functionality
* add helper method for paging output with hirb: page
* version bumps, including wirb and fancy_irb
* remove sketches dependency, it's a great gem, but very similar to interactive_editor
* Object#mlp alias for method_lookup_path

## 1.3.0 == 1.2.3
* add modern debundle note
* remove loading of .railsrc
* remove dbg method
* version bumps

## 1.2.2
* fix errors when inspect returns nil (e.g. CarrierWave uploaders)
* create legacy branch for 1.8.7 support

## 1.2.1
* fix newboson loader issue
* minor version bumps

## 1.2.0
* version bumps: hirb, awesome_print, coderay, g, methodfinder, method_source
* remove RVM helpers: Sorry, were too buggy...
* fix/improve 'cd' helper method
* improve readme
* move looksee gem to irbtools-more
* more little tweaks

## 1.1.1
* fix the Ripl.after_rc bug

## 1.1.0
* fix hirb loading/unicode issue + colorize tables (thanks to halan)
* colorize paged wirb output
* include method locator gem (improved ancestors)
* include looksee gem (aliased as Object#l/Object#ll and Object#edit)
* include method source gem (Object#src)
* small tweaks...

## 1.0.6
* add possibility to modify library callbacks without removing the library by using: replace_library_callback or add_library_callback
* fix hirb dependency issue
* readme improvements

## 1.0.5
* use paint gem for terminal colors

## 1.0.4
* improve error-handling
* fix broken loading of boson + interactive_editor

## 1.0.3
* fix post-install banner typo

## 1.0.2
* version bumps for zucker (rbx compatible) and wirb (improved generic object-description highlighting)

## 1.0.1
* add missing require 'rbconfig'

## 1.0.0
* gemify general helpers/rvm stuff ("every_day_irb", "rvm_loader")
* 6 different loading schemas: start, thread, autoload, sub_session, late, late_thread
  * load almost every feature via threads
* don't use zucker/alias_for, autload zucker/env (except zucker/os) for performance reasons
* add irbtools/minimal mode for starting Irbtools without the default set of libraries
* replace RV and RE with rv and re

## 0.8.8
* fix 0.8.7 file permissions
* add methodfinder gem
* don't depend on guessmethod anymore

## 0.8.7
* fix railsrc loading
* add ori gem for nice Object#ri calling
* minor tweaks

## 0.8.6
* windows support
* update hirb + activate unicode-drawn tables

## 0.8.5
* rails related fixes

## 0.8.4
* now using wirb instead of wirble

## 0.8.3
* improved/added rvm methods (use, gemset, rubies, gemsets)
  * RVM (Ruby API) constant gets autoloaded
* improved cd command
* don't load guessmethod by default (it's cool, but not always suited for production)
* more small changes

## 0.8.2
* only do irb specific features if in irb (ripl compatibility)
* more generic shell_name (in welcome message)

## 0.8.1
* rewrote irb_rocket: fancy_irb. No more workarounds needed, anymore.
* added sketches gem
* customizable welcome message
* more little fixes/enhancements

## 0.8.0
* added Object#ri method
* feature: extension package loading (e.g. irbtools-more)
* feature: loading in IRB.conf[:IRB_RC] (loading when a subirb starts, no more guessmethod rails errors)
* added rerequire (rrq) and ld load helper

## 0.7.4
* added workaround to use irb_rocket and hirb at the same time (basic hack, e.g. paging does not work)
* fixed little VERSION bug

## 0.7.3
* refactored file structure and added new Irbtools.add_lib method
* load railsrc if executed with rails and Irbtools.railsrc is set
* more little fixes

## 0.7.2
* fixed Rails 3 bug
* added boson gem (command repository)
* remember history when resetting or switching ruby version

## 0.7.1
* added method for starting a debugger

## 0.7.0
* initial release

J-_-L
