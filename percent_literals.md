# Percent Literals

* <a name="percent-q-shorthand"></a>
  Use `%Q{}` for single-line strings which require both interpolation and
  embedded double-quotes. For multi-line strings, prefer heredocs.
<sup>[[link](#percent-q-shorthand)]</sup>

  ```Ruby
  # bad:  no interpolation needed
  %Q{<div class="text">Some text</div>}
  # should be '<div class="text">Some text</div>'

  # bad:  no double-quotes
  %Q{This is #{quality} style}
  # should be "This is #{quality} style"

  # bad:  multiple lines
  %Q{<div>\n<span class="big">#{exclamation}</span>\n</div>}
  # should be a heredoc.

  # good:  requires interpolation, has quotes, single line
  %Q{<tr><td class="name">#{name}</td>}
  ```

* <a name="percent-q"></a>
  Avoid `%q` unless you have a string with both `'` and `"` in it. Regular
  string literals are more readable and should be preferred unless a lot of
  characters would have to be escaped in them.
<sup>[[link](#percent-q)]</sup>

  ```Ruby
  # bad
  name = %q{Bruce Wayne}
  time = %q{8 o'clock}
  question = %q{"What did you say?"}

  # good
  name = "Bruce Wayne"
  time = "8 o'clock"
  question = '"What did you say?"'
  quote = %q{<p class='quote'>"What did you say?"</p>}
  ```

* <a name="percent-r"></a>
  Use `%r` only for regular expressions matching *at least* one '/'
  character.
<sup>[[link](#percent-r)]</sup>

  ```Ruby
  # bad
  %r{\s+}

  # good
  %r{^/(.*)$}
  %r{^/blog/2011/(.*)$}
  ```

* <a name="percent-x"></a>
  Avoid the use of `%x` unless you're going to invoke a command with
  backquotes in it(which is rather unlikely).
<sup>[[link](#percent-x)]</sup>

  ```Ruby
  # bad
  date = %x{date}

  # good
  date = `date`
  echo = %x{echo `date`}
  ```

* <a name="percent-s"></a>
  Avoid the use of `%s`. It seems that the community has decided `:"some
  string"` is the preferred way to create a symbol with spaces in it.
<sup>[[link](#percent-s)]</sup>
