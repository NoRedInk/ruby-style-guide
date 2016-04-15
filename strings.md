# Strings

* <a name="string-interpolation"></a>
  Prefer string interpolation and string formatting instead of string
  concatenation:
<sup>[[link](#string-interpolation)]</sup>

  ```Ruby
  # bad
  email_with_name = user.name + " <" + user.email + ">"

  # good
  email_with_name = "#{user.name} <#{user.email}>"

  # good
  email_with_name = format("%s <%s>", user.name, user.email)
  ```

* <a name="pad-string-interpolation"></a>
  With interpolated expressions, there should be no padded-spacing inside the braces.
<sup>[[link](#pad-string-interpolation)]</sup>

  ```Ruby
  # bad
  "From: #{ user.first_name }, #{ user.last_name }"

  # good
  "From: #{user.first_name}, #{user.last_name}"
  ```

* <a name="consistent-string-literals"></a>
  Prefer double-quotes unless your string literal contains `"` or escape
  characters you want to suppress.  It's less hassle if you later need to
  add escapes, use interpolation, or insert an apostrophe.
<sup>[[link](#consistent-string-literals)]</sup>

  ```Ruby
  # bad
  name = 'Bozhidar'

  # good
  name = "Bozhidar"
  ```

* <a name="no-character-literals"></a>
  Don't use the character literal syntax `?x`. Since Ruby 1.9 it's basically
  redundant:  `?x` would interpreted as `"x"` (a string with a single character
  in it).
<sup>[[link](#no-character-literals)]</sup>

  ```Ruby
  # bad
  char = ?c

  # good
  char = "c"
  ```

* <a name="curlies-interpolate"></a>
  Don't leave out `{}` around instance and global variables being interpolated
  into a string.
<sup>[[link](#curlies-interpolate)]</sup>

  ```Ruby
  class Person
    attr_reader :first_name, :last_name

    def initialize(first_name, last_name)
      @first_name = first_name
      @last_name = last_name
    end

    # bad:  valid, but awkward
    def to_s
      "#@first_name #@last_name"
    end

    # good
    def to_s
      "#{@first_name} #{@last_name}"
    end
  end

  $global = 0
  # bad
  puts "$global = #$global"

  # good
  puts "$global = #{$global}"
  ```

* <a name="no-to-s"></a>
  Don't use `Object#to_s` on interpolated objects. It's invoked on them
  automatically.
<sup>[[link](#no-to-s)]</sup>

  ```Ruby
  # bad
  message = "This is the #{result.to_s}."

  # good
  message = "This is the #{result}."
  ```

* <a name="concat-strings"></a>
  Avoid using `String#+` when you need to construct large data chunks.
  Instead, use `String#<<`. Concatenation mutates the string instance in-place
  and is always faster than `String#+`, which creates a bunch of new string
  objects.
<sup>[[link](#concat-strings)]</sup>

  ```Ruby
  # bad
  html = ""
  html += "<h1>Page title</h1>"

  paragraphs.each do |paragraph|
    html += "<p>#{paragraph}</p>"
  end

  # good and also fast
  html = ""
  html << "<h1>Page title</h1>"

  paragraphs.each do |paragraph|
    html << "<p>#{paragraph}</p>"
  end
  ```

* <a name="dont-abuse-gsub"></a>
  Don't use `String#gsub` in scenarios in which you can use a faster more specialized alternative.
<sup>[[link](#dont-abuse-gsub)]</sup>

    ```Ruby
    url = "http://example.com"
    str = "lisp-case-rules"

    # bad
    url.gsub("http://", "https://")
    str.gsub("-", "_")

    # good
    url.sub("http://", "https://")
    str.tr("-", "_")
    ```

* <a name="heredocs"></a>
  When using heredocs for multi-line strings keep in mind the fact that they
  preserve leading whitespace by default. It's a good practice to employ
  Ruby 2.3's `<<~` trimming heredoc syntax or use some margin indicator
  to trim the excessive whitespace.
<sup>[[link](#heredocs)]</sup>

  ```Ruby
  # good:  requires Ruby 2.3+
  code = <<~END
    def test
      some_method
      other_method
    end
  END
  # => "def test\n  some_method\n  other_method\nend\n"

  # passable:  support older Ruby versions
  code = <<-END.gsub(/^\s+\|/, "")
    |def test
    |  some_method
    |  other_method
    |end
  END
  # => "def test\n  some_method\n  other_method\nend\n"
  ```
