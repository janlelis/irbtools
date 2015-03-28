## Advanced Tweaking
### Welcome Message

The welcome message can be customized with `Irbtools.welcome_message=`

### Customize Libraries to Load

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
:   The library is required just before showing the prompt.
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
