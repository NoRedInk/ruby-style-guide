# Source Code Layout

* <a name="utf-8"></a>
  Use `UTF-8` as the source file encoding.
<sup>[[link](#utf-8)]</sup>

* <a name="spaces-indentation"></a>
  Use two **spaces** per indentation level (a.k.a. soft tabs). No hard tabs.
<sup>[[link](#spaces-indentation)]</sup>

  ```Ruby
  # bad: four spaces
  def some_method
      do_something
  end

  # good
  def some_method
    do_something
  end
  ```

* <a name="crlf"></a>
  Use Unix-style line endings. (BSD/Solaris/Linux/OS X users are covered by
  default, but Windows users have to be extra careful.)
<sup>[[link](#crlf)]</sup>

  * If you're using Git you might want to add the following
    configuration setting to protect your project from Windows line
    endings creeping in:

    ```bash
    $ git config --global core.autocrlf true
    ```

* <a name="no-semicolon"></a>
  Don't use `;` to separate statements and expressions. As a corollary, use one
  expression per line.
<sup>[[link](#no-semicolon)]</sup>

  ```Ruby
  # bad
  puts "foobar"; # superfluous semicolon

  puts "foo"; puts "bar" # two expressions on the same line

  # good
  puts "foobar"

  puts "foo"
  puts "bar"

  puts "foo", "bar" # this applies to puts in particular
  ```

* <a name="single-line-classes"></a>
  Prefer a single-line format for class definitions with no body.
<sup>[[link](#single-line-classes)]</sup>

  ```Ruby
  # bad
  class FooError < StandardError
  end

  # passable
  class FooError < StandardError; end

  # good
  FooError = Class.new(StandardError)
  ```

* <a name="spaces-operators"></a>
  Use spaces around operators, after commas, colons and semicolons, and around
  `{` and before `}` when used in blocks. Whitespace might be (mostly)
  irrelevant to the Ruby interpreter, but its proper use is the key to writing
  easily readable code.
<sup>[[link](#spaces-operators)]</sup>

  ```Ruby
  sum = 1 + 2
  a, b = 1, 2
  [1, 2, 3].each { |e| puts e }
  class FooError < StandardError; end
  ```

  The only exception, regarding operators, is the exponent operator:

  ```Ruby
  # bad
  e = M * c ** 2

  # good
  e = M * c**2
  ```

* <a name="no-spaces-braces"></a>
  No spaces after `(`, `[`, or `{` when used for hash literals or interpolation.
  No spaces before `]`, `)`, or `}` when used for hash literals
  or interpolation.
<sup>[[link](#no-spaces-braces)]</sup>

  ```Ruby
  # bad
  some( arg ).other
  [ 1, 2, 3 ].size

  # good
  some(arg).other
  [1, 2, 3].size
  ```

* <a name="no-space-bang"></a>
  No space after `!`.
<sup>[[link](#no-space-bang)]</sup>

  ```Ruby
  # bad
  ! something

  # good
  !something
  ```

* <a name="no-space-inside-range-literals"></a>
  No space inside range literals.
<sup>[[link](#no-space-inside-range-literals)]</sup>

    ```Ruby
    # bad
    1 .. 3
    "a" ... "z"

    # good
    1..3
    "a"..."z"
    ```

* <a name="indent-when-to-case"></a>
  Indent `when` as deep as `case`. This is the style established in both
  "The Ruby Programming Language" and "Programming Ruby".
<sup>[[link](#indent-when-to-case)]</sup>

  ```Ruby
  # bad
  case
    when song.name == "Misty"
      puts "Not again!"
    when song.duration > 120
      puts "Too long!"
    when Time.now.hour > 21
      puts "It's too late"
    else
      song.play
  end

  # good
  case
  when song.name == "Misty"
    puts "Not again!"
  when song.duration > 120
    puts "Too long!"
  when Time.now.hour > 21
    puts "It's too late"
  else
    song.play
  end
  ```

* <a name="indent-conditional-assignment"></a>
  When assigning the result of a conditional expression to a variable,
  move the conditional to a new line and indent one level.
<sup>[[link](#indent-conditional-assignment)]</sup>

  ```Ruby
  # bad:  pretty convoluted
  kind = case year
  when 1850..1889 then "Blues"
  when 1890..1909 then "Ragtime"
  when 1910..1929 then "New Orleans Jazz"
  when 1930..1939 then "Swing"
  when 1940..1950 then "Bebop"
  else "Jazz"
  end

  result = if some_cond
    calc_something
  else
    calc_something_else
  end

  # bad:  random indentation and all lines change with the variable name
  kind = case year
         when 1850..1889 then "Blues"
         when 1890..1909 then "Ragtime"
         when 1910..1929 then "New Orleans Jazz"
         when 1930..1939 then "Swing"
         when 1940..1950 then "Bebop"
         else "Jazz"
         end

  result = if some_cond
             calc_something
           else
             calc_something_else
           end

  # good (and a bit more width efficient)
  kind =
    case year
    when 1850..1889 then "Blues"
    when 1890..1909 then "Ragtime"
    when 1910..1929 then "New Orleans Jazz"
    when 1930..1939 then "Swing"
    when 1940..1950 then "Bebop"
    else "Jazz"
    end

  result =
    if some_cond
      calc_something
    else
      calc_something_else
    end
  ```

* <a name="empty-lines-between-methods"></a>
  Use empty lines between method definitions and also to break up methods
  into logical paragraphs internally.
<sup>[[link](#empty-lines-between-methods)]</sup>

  ```Ruby
  def some_method
    data = initialize(options)

    data.manipulate!

    data.result
  end

  def some_method
    result
  end
  ```

* <a name="no-trailing-params-comma"></a>
  Avoid a comma after the last parameter in a method call when the
  parameters are on the same line.
<sup>[[link](#no-trailing-params-comma)]</sup>

  ```Ruby
  # bad
  some_method(size, count, color, )

  # good
  some_method(size, count, color)
  ```

* <a name="spaces-around-equals"></a>
  Use spaces around the `=` operator when assigning default values to method
  parameters:
<sup>[[link](#spaces-around-equals)]</sup>

  ```Ruby
  # bad
  def some_method(arg1=:default, arg2=nil, arg3=[])
    # do something...
  end

  # good
  def some_method(arg1 = :default, arg2 = nil, arg3 = [])
    # do something...
  end
  ```

  While several Ruby books suggest the first style, the second is much more
  prominent in practice (and arguably a bit more readable).

* <a name="no-trailing-backslash"></a>
  Avoid using line continuation (`\`).
<sup>[[link](#no-trailing-backslash)]</sup>

  ```Ruby
  # bad
  result = 1 - \
           2

  result = 1 \
           - 2

  # passable
  long_string = "First part of the long string" \
                " and second part of the long string"

  # good
  long_string = "First part of the long string" +
                " and second part of the long string"
  ```

* <a name="consistent-multi-line-chains"></a>
  When continuing a chained method invocation on another line,
  include the `.` on the first line to indicate that the
  expression continues.
<sup>[[link](#consistent-multi-line-chains)]</sup>

  ```Ruby
  # bad:  makes the code harder to play with in a REPL
  one.two.three
    .four

  # passable:  irb friendly
  one.two.three.
    four

  # good
  one.
    two.
    three.
    four
  ```

* <a name="no-double-indent"></a>
    Align the parameters of a method call if they span more than one
    line. When aligning parameters, single indent parameter lines.
<sup>[[link](#no-double-indent)]</sup>

  ```Ruby
  # bad:  line is too long
  def send_mail(source)
    Mailer.deliver(to: "bob@example.com", from: "us@example.com", subject: "Important message", body: source.text)
  end

  # bad:  double indent
  def send_mail(source)
    Mailer.deliver(
        to: "bob@example.com",
        from: "us@example.com",
        subject: "Important message",
        body: source.text)
  end

  # bad:  random indention that can easily cause all lines to change
  def send_mail(source)
    Mailer.deliver(to: "bob@example.com",
                   from: "us@example.com",
                   subject: "Important message",
                   body: source.text)
  end

  # good:  normal indent
  def send_mail(source)
    Mailer.deliver(
      to: "bob@example.com",
      from: "us@example.com",
      subject: "Important message",
      body: source.text
    )
  end
  ```

* <a name="align-multiline-arrays"></a>
  Align the elements of array literals spanning multiple lines.
<sup>[[link](#align-multiline-arrays)]</sup>

  ```Ruby
  # bad:  single indent
  menu_item = ["Spam", "Spam", "Spam", "Spam", "Spam", "Spam", "Spam", "Spam",
    "Baked beans", "Spam", "Spam", "Spam", "Spam", "Spam"]

  # passable
  menu_item =
    ["Spam", "Spam", "Spam", "Spam", "Spam", "Spam", "Spam", "Spam",
     "Baked beans", "Spam", "Spam", "Spam", "Spam", "Spam"]

  # good
  menu_item = [
    "Spam", "Spam", "Spam", "Spam", "Spam", "Spam", "Spam", "Spam",
    "Baked beans", "Spam", "Spam", "Spam", "Spam", "Spam"
  ]
  ```

* <a name="underscores-in-numerics"></a>
  Add underscores to large numeric literals to improve their readability.
<sup>[[link](#underscores-in-numerics)]</sup>

  ```Ruby
  # bad:  how many 0s are there?
  num = 1000000

  # good:  much easier to parse for the human brain
  num = 1_000_000
  ```

* <a name="rdoc-conventions"></a>
    Use RDoc and its conventions for API documentation.  Don't put an
    empty line between the comment block and the `def`.
<sup>[[link](#rdoc-conventions)]</sup>

* <a name="80-character-limits"></a>
  Limit lines to 80 characters.
<sup>[[link](#80-character-limits)]</sup>

* <a name="no-trailing-whitespace"></a>
  Avoid trailing whitespace.
<sup>[[link](#no-trailing-whitespace)]</sup>

* <a name="newline-eof"></a>
  End each file with a newline.
<sup>[[link](#newline-eof)]</sup>

* <a name="no-block-comments"></a>
    Don't use block comments. They cannot be preceded by whitespace and are not
    as easy to spot as regular comments.
<sup>[[link](#no-block-comments)]</sup>

  ```Ruby
  # bad
  =begin
  comment line
  another comment line
  =end

  # good
  # comment line
  # another comment line
  ```


