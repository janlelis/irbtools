# Irbtools (More) Changelog

## 3.0 (final)

Retire irbtools-more:

* Move looksee to core irbtools
* Move core_docs to core irbtools
* Remove bond (outdated)
* Leave binding_of_caller optional

## 2.5.0
* Bump binding_of_caller & core_docs for Ruby 3.0

## 2.4.1
* Loosen Ruby dependency to allow Ruby 3.0

## 2.4.0
* Bump looksee & core_docs for Ruby 2.7

## 2.3.1
* Loosen irbrtools-more dependency to irbtools (allow 3.x)

## 2.3.0
* Remove dependency to did_you_mean, since it is now a default gem anyways
* Version bump: irbtools, looksee, core_docs, and binding_of_caller

## 2.2.1
* Add core_docs dependency

## 2.2.0
* Re-enable looksee (not comptible with Ruby 2.3, but does not crash anymore during install)

## 2.1.0
* Ruby 2.3 compat: Upgrade did_you_mean to ~> 1.0
* Ruby 2.3 compat: Disable looksee gem as long it is not adapted for 2.3

## 2.0.0
* Integrate more-repo into irbtools main repo
* Improve auto-completion
* Remove Object#l alias for looksee, use Object#lp

## 1.7.2
* Bump did_you_mean and looksee (Ruby 2.2 compat)

## 1.7.1
* Bump did_you_mean version

## 1.7.0
* Bump looksee
* Ruby 1.9.3 required
* Add did_you_mean gem

## 1.6.1
* Add binding_of_caller
* Alias looksee to Object#lp instead of Object#ls

## 1.6.0
* (nothing)

## 1.5.2
* Ruby 2.1 Compatibility / Update looksee gem
* Be less restrictive in gem dependencies

## 1.5.1
* (nothing)

## 1.5.0
* Ruby 2.0 Compatibility
* Drop 1.8 Support
* Drop DrX gem

## 1.2.0
* add looksee

## 0.3.2
* load in threads (irbtools 1.0)
* remove jeweler
