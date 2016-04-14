# Regular Expressions

* <a name="no-regexp-for-plaintext"></a>
  Don't use regular expressions if you just need plain text search in string:
  `string["text"]`
<sup>[[link](#no-regexp-for-plaintext)]</sup>

* <a name="regexp-string-index"></a>
  For simple constructions you can use regexp directly through string index.
<sup>[[link](#regexp-string-index)]</sup>

  ```Ruby
  match = string[/regexp/]             # get content of matched regexp
  first_group = string[/text(grp)/, 1] # get content of captured group
  string[/text (grp)/, 1] = "replace"  # string => "text replace"
  ```

* <a name="non-capturing-regexp"></a>
  Use non-capturing groups when you don't use the captured result.
<sup>[[link](#non-capturing-regexp)]</sup>

  ```Ruby
  # bad
  /(first|second)/

  # good
  /(?:first|second)/
  ```

* <a name="no-numbered-regexes"></a>
  Avoid using numbered groups as it can be hard to track what they contain.
  Named groups can be used instead.
<sup>[[link](#no-numbered-regexes)]</sup>

  ```Ruby
  # bad
  /(regexp)/ =~ string
  ...
  process Regexp.last_match(1)

  # good
  /(?<meaningful_var>regexp)/ =~ string
  ...
  process meaningful_var
  ```

* <a name="limit-escapes"></a>
  Character classes have only a few special characters you should care about:
  `^`, `-`, `\`, `]`, so don't escape `.` or brackets in `[]`.
<sup>[[link](#limit-escapes)]</sup>

* <a name="caret-and-dollar-regexp"></a>
  Be careful with `^` and `$` as they match start/end of line, not string
  endings.  If you want to match the whole string use: `\A` and `\z` (not to be
  confused with `\Z` which is the equivalent of `/\n?\z/`).
<sup>[[link](#caret-and-dollar-regexp)]</sup>

  ```Ruby
  string = "some injection\nusername"
  string[/^username$/]   # matches
  string[/\Ausername\z/] # doesn't match
  ```

* <a name="comment-regexes"></a>
  Use `x` modifier for complex regexps. This makes them more readable and you
  can add some useful comments. Just be careful as spaces are ignored.
<sup>[[link](#comment-regexes)]</sup>

  ```Ruby
  regexp = /
    start         # some text
    \s            # white space char
    (group)       # first group
    (?:alt1|alt2) # some alternation
    end
  /x
  ```

* <a name="gsub-blocks"></a>
  For complex replacements `sub`/`gsub` can be used with a block or a hash.
<sup>[[link](#gsub-blocks)]</sup>

  ```Ruby
  words = "foo bar"
  words.sub(/f/, "f" => "F") # => "Foo bar"
  words.gsub(/\w+/) { |word| word.capitalize } # => "Foo Bar"
  ```
