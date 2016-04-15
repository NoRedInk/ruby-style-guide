# Syntax

* <a name="double-colons"></a>
    Use `::` only to reference constants(this includes classes and
    modules). Do not use `::` for regular method invocation.
<sup>[[link](#double-colons)]</sup>

  ```Ruby
  # bad
  SomeClass::some_method
  some_object::some_method

  # good
  SomeClass.some_method
  some_object.some_method
  SomeModule::SomeClass::SOME_CONST
  ```

* <a name="method-parens"></a>
    Use `def` with parentheses when there are parameters. Omit the
    parentheses when the method doesn't accept any parameters.
<sup>[[link](#method-parens)]</sup>

   ```Ruby
   # bad
   def some_method()
     # body omitted
   end

   # good
   def some_method
     # body omitted
   end

   # bad
   def some_method_with_parameters param1, param2
     # body omitted
   end

   # good
   def some_method_with_parameters(param1, param2)
     # body omitted
   end
   ```

* <a name="optional-arguments"></a>
    Define optional arguments at the end of the list of arguments.
    Results can be surprising when calling methods that have
    optional arguments at the front of the list.
<sup>[[link](#optional-arguments)]</sup>

  ```Ruby
  # bad
  def some_method(a = 1, b = 2, c, d)
    puts "#{a}, #{b}, #{c}, #{d}"
  end

  some_method("w", "x") # => "1, 2, w, x"
  some_method("w", "x", "y") # => "w, 2, x, y"
  some_method("w", "x", "y", "z") # => "w, x, y, z"

  # good
  def some_method(c, d, a = 1, b = 2)
    puts "#{a}, #{b}, #{c}, #{d}"
  end

  some_method("w", "x") # => "w, x, 1, 2"
  some_method("w", "x", "y") # => "w, x, y, 2"
  some_method("w", "x", "y", "z") # => "w, x, y, z"
  ```

* <a name="parallel-assignment"></a>
    Avoid the use of parallel assignment for defining variables. Parallel
    assignment is allowed when it is the return of a method call, used with
    the splat operator, when used to swap variable assignment, or for creating
    obviously related data clumps. Parallel assignment is less readable than
    separate assignment.
<sup>[[link](#parallel-assignment)]</sup>

  ```Ruby
  # bad
  a, b, c, d = "foo", "bar", "baz", "foobar"

  # good
  a = "foo"
  b = "bar"
  c = "baz"
  d = "foobar"

  # good:  swapping variable assignment
  # Swapping variable assignment is a special case because it will allow you to
  # swap the values that are assigned to each variable.
  a = "foo"
  b = "bar"

  a, b = b, a
  puts a # => "bar"
  puts b # => "foo"

  # good:  method return
  def multi_return
    [1, 2]
  end

  first, second = multi_return

  # good:  use with splat
  first, *list = [1, 2, 3, 4]

  hello_array = *"Hello"

  a = *(1..3)

  # good:  data clump
  x, y = 4, 2
  ```

* <a name="no-for-loops"></a>
    Do not use `for`. Iterators should be used instead. `for` is implemented in
    terms of `each` (so you're adding a level of indirection), but with a twist:
    `for` doesn't introduce a new scope (unlike `each`) and variables defined
    in its block will be visible outside it.
<sup>[[link](#no-for-loops)]</sup>

  ```Ruby
  arr = [1, 2, 3]

  # bad
  for elem in arr do
    puts elem
  end

  # note that elem is accessible outside of the for loop
  elem # => 3

  # good
  arr.each { |elem| puts elem }

  # elem is not accessible outside each's block
  elem # => NameError: undefined local variable or method `elem'
  ```

* <a name="no-then"></a>
  Do not use `then` for multi-line `if`/`unless`.
<sup>[[link](#no-then)]</sup>

  ```Ruby
  # bad
  if some_condition then
    # body omitted
  end

  # good
  if some_condition
    # body omitted
  end
  ```

* <a name="same-line-condition"></a>
  Always put the condition on the same line as the `if`/`unless` in a
  multi-line conditional.
<sup>[[link](#same-line-condition)]</sup>

  ```Ruby
  # bad
  if
    some_condition
    do_something
    do_something_else
  end

  # good
  if some_condition
    do_something
    do_something_else
  end
  ```

* <a name="ternary-operator"></a>
  Favor the ternary operator(`?:`) over `if`/`then`/`else`/`end` constructs.
  It's more common and obviously more concise.
<sup>[[link](#ternary-operator)]</sup>

  ```Ruby
  # bad
  result = if some_condition then something else something_else end

  # good
  result = some_condition ? something : something_else
  ```

* <a name="no-nested-ternary"></a>
  Use one expression per branch in a ternary operator. This
  also means that ternary operators must not be nested. Prefer
  `if`/`else` constructs in these cases.
<sup>[[link](#no-nested-ternary)]</sup>

  ```Ruby
  # bad
  some_condition ? (nested_condition ? nested_something : nested_something_else) : something_else

  # good
  if some_condition
    nested_condition ? nested_something : nested_something_else
  else
    something_else
  end
  ```

* <a name="no-semicolon-ifs"></a>
  Do not use `if x; ...`. Use the ternary
  operator instead.
<sup>[[link](#no-semicolon-ifs)]</sup>

  ```Ruby
  # bad
  result = if some_condition; something else something_else end

  # good
  result = some_condition ? something : something_else
  ```

* <a name="use-if-case-returns"></a>
  Leverage the fact that `if` and `case` are expressions which return a
  result.
<sup>[[link](#use-if-case-returns)]</sup>

  ```Ruby
  # bad
  if condition
    result = x
  else
    result = y
  end

  # good
  result =
    if condition
      x
    else
      y
    end
  ```

* <a name="one-line-cases"></a>
  Use `when x then ...` for one-line cases. The alternative syntax `when x:
  ...` has been removed as of Ruby 1.9.
<sup>[[link](#one-line-cases)]</sup>

* <a name="no-when-semicolons"></a>
  Do not use `when x; ...`. See the previous rule.
<sup>[[link](#no-when-semicolons)]</sup>

* <a name="bang-not-not"></a>
  Use `!` instead of `not` for boolean negation.
<sup>[[link](#bang-not-not)]</sup>

  ```Ruby
  # bad:  parentheses are required because of op precedence
  x = (not something)

  # good
  x = !something
  ```

* <a name="and-or-not"></a>
  The `and`, `or`, and `not` keywords are for flow control, not
  conditional comparisons like `&&`, `||`, and `!`. They have a different
  operator precedence to support this usage.
<sup>[[link](#and-or-not)]</sup>

  ```Ruby
  # bad:  conditional comparisons
  if some_condition and not some_other_condition
    do_something
  end

  # bad:  flow control
  # same as: size = (ARGV.shift || abort "USAGE:  #{$PROGRAM_NAME} SIZE")
  size = ARGV.shift || abort "USAGE:  #{$PROGRAM_NAME} SIZE"

  # good:  conditional comparisons
  if some_condition && !some_other_condition
    do_something
  end

  # good:  flow control
  # same as: (size = ARGV.shift) or (abort "USAGE:  #{$PROGRAM_NAME} SIZE")
  size = ARGV.shift or abort "USAGE:  #{$PROGRAM_NAME} SIZE"
  ```

* <a name="no-multiline-ternary"></a>
  Avoid multi-line `?:` (the ternary operator); use `if`/`unless` instead.
<sup>[[link](#no-multiline-ternary)]</sup>

* <a name="if-as-a-modifier"></a>
  Favor modifier `if`/`unless` usage when you have a single-line body. Another
  good alternative is the usage of flow control `and`/`or`/`not`.
<sup>[[link](#if-as-a-modifier)]</sup>

  ```Ruby
  # bad
  if some_condition
    do_something
  end

  # good
  do_something if some_condition

  # another good option
  some_condition and do_something
  ```

* <a name="no-multiline-if-modifiers"></a>
  Avoid modifier `if`/`unless` usage at the end of a non-trivial multi-line
  block.
<sup>[[link](#no-multiline-if-modifiers)]</sup>

  ```Ruby
  # bad
  10.times do
    # multi-line body omitted
  end if some_condition

  # good
  if some_condition
    10.times do
      # multi-line body omitted
    end
  end
  ```

* <a name="no-nested-modifiers"></a>
  Avoid nested modifier `if`/`unless`/`while`/`until` usage. Favor `&&`/`||` if
  appropriate.
<sup>[[link](#no-nested-modifiers)]</sup>

  ```Ruby
  # bad
  do_something if other_condition if some_condition

  # good
  do_something if some_condition && other_condition
  ```

* <a name="unless-for-negatives"></a>
  Favor `unless` over `if !...` for negative conditions (or flow control `or`).
<sup>[[link](#unless-for-negatives)]</sup>

  ```Ruby
  # bad
  do_something if !some_condition

  # bad
  do_something if not some_condition

  # good
  do_something unless some_condition

  # another good option
  some_condition or do_something
  ```

* <a name="no-else-with-unless"></a>
  Do not use `unless` with `else`. Rewrite these with the positive case first.
<sup>[[link](#no-else-with-unless)]</sup>

  ```Ruby
  # bad
  unless success?
    puts "failure"
  else
    puts "success"
  end

  # good
  if success?
    puts "success"
  else
    puts "failure"
  end
  ```

* <a name="keep-unless-simple"></a>
  Don't use `unless` with compound conditionals.
<sup>[[link](#keep-unless-simple)]</sup>

  ```Ruby
  # bad
  unless question? || other_question?
    puts "confusing"
  end

  # good
  if !question? && !other_question?
    puts "easier to grok"
  end

  # good
  unless question?
    puts "simple"
  end
  ```

* <a name="side-effect-conditionals"></a>
  Don't bury side effects in compound conditionals.
<sup>[[link](#side-effect-conditionals)]</sup>

  ```Ruby
  # bad
  if cool_dude && user.save && wearing_sunglasses
    # ...
  end

  # good:  explicit change
  if cool_dude
    user_saved = user.save
    if user_saved && wearing_sunglasses
      # ...
    end
  end

  # good:  simple conditional
  if user.save
    # ...
  end
  ```

* <a name="no-parens-if"></a>
  Don't use parentheses around the condition of an
  `if`/`unless`/`while`/`until`.
<sup>[[link](#no-parens-if)]</sup>

  ```Ruby
  # bad
  if (x > 10)
    # body omitted
  end

  # good
  if x > 10
    # body omitted
  end
  ```

Note that there is an exception to this rule, namely [safe assignment in
condition](#safe-assignment-in-condition).

* <a name="no-multiline-while-do"></a>
  Do not use `while`/`until ... do` for multi-line `while`/`until`.
<sup>[[link](#no-multiline-while-do)]</sup>

  ```Ruby
  # bad
  while x > 5 do
    # body omitted
  end

  until x > 5 do
    # body omitted
  end

  # good
  while x > 5
    # body omitted
  end

  until x > 5
    # body omitted
  end
  ```

* <a name="while-as-a-modifier"></a>
  Favor modifier `while`/`until` usage when you have a single-line body.
<sup>[[link](#while-as-a-modifier)]</sup>

  ```Ruby
  # bad
  while some_condition
    do_something
  end

  # good
  do_something while some_condition
  ```

* <a name="until-for-negatives"></a>
  Favor `until` over `while !...` for negative conditions.
<sup>[[link](#until-for-negatives)]</sup>

  ```Ruby
  # bad
  do_something while !some_condition

  # good
  do_something until some_condition
  ```

* <a name="infinite-loop"></a>
  Use `Kernel#loop` instead of `while`/`until` when you need an infinite loop.
<sup>[[link](#infinite-loop)]</sup>

    ```ruby
    # bad
    while true
      do_something
    end

    until false
      do_something
    end

    # good
    loop do
      do_something
    end
    ```

* <a name="loop-with-break"></a>
  Use `Kernel#loop` with `break` rather than `begin`/`end`/`until` or
  `begin`/`end`/`while` for post-loop tests.
<sup>[[link](#loop-with-break)]</sup>

  ```Ruby
  # bad
  begin
    puts val
    val += 1
  end while val < 0

  # good
  loop do
    puts val
    val += 1
    break unless val < 0
  end
  ```

* <a name="no-dsl-parens"></a>
  Omit parentheses around parameters for methods that are part of an internal
  DSL (e.g. Rake, Rails, RSpec), methods that have "keyword" status in Ruby
  (e.g. `attr_reader`, `puts`) and attribute access methods. Use parentheses
  around the arguments of all other method invocations.
<sup>[[link](#no-dsl-parens)]</sup>

  ```Ruby
  class Person
    attr_reader :name, :age

    # omitted
  end

  temperance = Person.new("Temperance", 30)
  temperance.name

  puts temperance.age

  x = Math.sin(y)
  array.delete(e)

  bowling.score.should == 0
  ```

* <a name="no-braces-opts-hash"></a>
  Omit the outer braces around an implicit options hash.
<sup>[[link](#no-braces-opts-hash)]</sup>

  ```Ruby
  # bad
  user.set({name: "John", age: 45, permissions: { read: true }})

  # good
  user.set(name: "John", age: 45, permissions: { read: true })
  ```

* <a name="no-dsl-decorating"></a>
  Omit both the outer braces and parentheses for methods that are part of an
  internal DSL.
<sup>[[link](#no-dsl-decorating)]</sup>

  ```Ruby
  class Person < ActiveRecord::Base
    # bad
    validates(:name, {presence: true, length: { within: 1..10 }})

    # good
    validates :name, presence: true, length: { within: 1..10 }
  end
  ```

* <a name="no-args-no-parens"></a>
  Omit parentheses for method calls with no arguments.
<sup>[[link](#no-args-no-parens)]</sup>

  ```Ruby
  # bad
  Kernel.exit!()
  2.even?()
  fork()
  "test".upcase()

  # good
  Kernel.exit!
  2.even?
  fork
  "test".upcase
  ```

* <a name="single-action-blocks"></a>
  Use the proc invocation shorthand when the invoked method is the only operation of a block.
<sup>[[link](#single-action-blocks)]</sup>

  ```Ruby
  # bad
  names.map { |name| name.upcase }

  # good
  names.map(&:upcase)
  ```

* <a name="block-style"></a>
  Use `{...}` when defining a block where the return value matters and
  `do...end` when using a block for flow control or side effects.  Many guides
  recommend `{...}` for single-line blocks and `do...end` for multiple lines,
  but you can already tell that at a glance and it's helpful to signal the
  intended usage instead.  That said, single-line `do...end` is awkward, so do
  split those across multiple lines, even if it's short.
<sup>[[link](#block-style)]</sup>

  ```Ruby
  names = %w[bozhidar steve sarah]

  # bad:  block return value matters
  names.map do |name|
    name.capitalize
  end

  # good:  map() always uses {...} because the return value always matters
  names.map { |name| name.capitalize }

  # bad:  block return value is ignored; used for side effects (printing)
  names.each { |name| puts name.capitalize }

  # passable:  awkward
  names.each do |name| puts name.capitalize end

  # good:  each() always uses do...end because the return value never matters
  names.each do |name|
    puts name.capitalize
  end

  # bad:  block return value matters
  headers = File.open("names.csv") do |f|
    f.gets
  end

  # bad:  block used for flow control
  File.open("sorted_names.txt") { |f|
    f.each_cons(2) do |first, last|
      puts "#{first.strip} comes before #{last.strip}"
    end
  }

  # good:  {...} and do...end clarify intent of open() usage
  headers = File.open("names.csv") { |f| f.gets }

  File.open("sorted_names.txt") do |f|
    f.each_cons(2) do |first, last|
      puts "#{first.strip} comes before #{last.strip}"
    end
  end
  ```

* <a name="block-argument"></a>
  Consider using explicit block argument to avoid writing block literal that
  just passes its arguments to another block. Beware of the performance impact,
  though, as the block gets converted to a Proc.
<sup>[[link](#block-argument)]</sup>

  ```Ruby
  require "tempfile"

  # bad
  def with_tmp_dir
    Dir.mktmpdir do |tmp_dir|
      Dir.chdir(tmp_dir) { |dir| yield dir }  # block just passes arguments
    end
  end

  # good
  def with_tmp_dir(&block)
    Dir.mktmpdir do |tmp_dir|
      Dir.chdir(tmp_dir, &block)
    end
  end

  with_tmp_dir do |dir|
    puts "dir is accessible as a parameter and pwd is set: #{dir}"
  end
  ```

* <a name="no-explicit-return"></a>
  Avoid `return` where not required for flow control.
<sup>[[link](#no-explicit-return)]</sup>

  ```Ruby
  # bad
  def some_method(some_arr)
    return some_arr.size
  end

  # good
  def some_method(some_arr)
    some_arr.size
  end
  ```

* <a name="no-self-unless-required"></a>
  Avoid `self` where not required. (It is only required when calling a self
  write accessor.)
<sup>[[link](#no-self-unless-required)]</sup>

  ```Ruby
  # bad
  def ready?
    if self.last_reviewed_at > self.last_updated_at
      self.worker.update(self.content, self.options)
      self.status = :in_progress
    end
    self.status == :verified
  end

  # good
  def ready?
    if last_reviewed_at > last_updated_at
      worker.update(content, options)
      self.status = :in_progress
    end
    status == :verified
  end
  ```

* <a name="no-shadowing"></a>
  As a corollary, avoid shadowing methods with local variables unless they are
  both equivalent.
<sup>[[link](#no-shadowing)]</sup>

  ```Ruby
  class Foo
    attr_accessor :options

    # ok
    def initialize(options)
      self.options = options
      # both options and self.options are equivalent here
    end

    # bad
    def do_something(options = {})
      unless options[:when] == :later
        output(self.options[:message])
      end
    end

    # good
    def do_something(params = {})
      unless params[:when] == :later
        output(options[:message])
      end
    end
  end
  ```

* <a name="safe-assignment-in-condition"></a>
  Don't use the return value of `=` (an assignment) in conditional expressions
  unless the assignment is wrapped in parentheses. This is a fairly popular
  idiom among Rubyists that's sometimes referred to as *safe assignment in
  condition*.
<sup>[[link](#safe-assignment-in-condition)]</sup>

  ```Ruby
  # bad
  if v = array.grep(/foo/)
    do_something(v)
    ...
  end

  # good
  if (v = array.grep(/foo/))
    do_something(v)
    ...
  end

  # passable
  v = array.grep(/foo/)
  if v
    do_something(v)
    ...
  end
  ```

* <a name="self-assignment"></a>
  Use shorthand self assignment operators whenever applicable.
<sup>[[link](#self-assignment)]</sup>

  ```Ruby
  # bad
  x = x + y
  x = x * y
  x = x**y
  x = x / y
  x = x || y
  x = x && y

  # good
  x += y
  x *= y
  x **= y
  x /= y
  x ||= y
  x &&= y
  ```

* <a name="double-pipe-for-uninit"></a>
  Use `||=` to initialize variables only if they're not already initialized.
<sup>[[link](#double-pipe-for-uninit)]</sup>

  ```Ruby
  # bad
  name = name ? name : "Bozhidar"

  # bad
  name = "Bozhidar" unless name

  # good:  set name to "Bozhidar", only if it's nil or false
  name ||= "Bozhidar"
  ```

* <a name="no-double-pipes-for-bools"></a>
  Don't use `||=` to initialize boolean variables. (Consider what would happen
  if the current value happened to be `false`.)
<sup>[[link](#no-double-pipes-for-bools)]</sup>

  ```Ruby
  # bad:  would set enabled to true even if it was false
  enabled ||= true

  # good
  enabled = true if enabled.nil?
  ```

* <a name="double-amper-preprocess"></a>
  Use `&&=` to preprocess variables that may or may not exist. Using `&&=`
  will change the value only if it exists, removing the need to check its
  existence with `if`.
<sup>[[link](#double-amper-preprocess)]</sup>

  ```Ruby
  # bad
  if something
    something = something.downcase
  end

  # bad
  something = something ? something.downcase : nil

  # ok
  something = something.downcase if something

  # passable
  something = something && something.downcase

  # good
  something &&= something.downcase
  ```

* <a name="no-case-equality"></a>
  Avoid explicit use of the case equality operator `===`. As its name implies
  it is meant to be used implicitly by `case` expressions and outside of them it
  yields some pretty confusing code.
<sup>[[link](#no-case-equality)]</sup>

  ```Ruby
  # bad
  Array === something
  (1..100) === 7
  /something/ === some_string

  # good
  something.is_a?(Array)
  (1..100).include?(7)
  some_string =~ /something/
  ```

* <a name="eql"></a>
  Do not use `eql?` when using `==` will do. The stricter comparison semantics
  provided by `eql?` are rarely needed in practice.
<sup>[[link](#eql)]</sup>

  ```Ruby
  # bad:  eql? is the same as == for strings
  "ruby".eql? some_str

  # good
  "ruby" == some_str
  1.0.eql? x # eql? makes sense here if want to differentiate between Fixnum and Float 1
  ```

* <a name="no-cryptic-perlisms"></a>
  Avoid using Perl-style special variables (like `$:`, `$;`, etc.). They are
  quite cryptic and their use in anything but one-liner scripts is discouraged.
  Use the human-friendly aliases.  Some aliases require the `English` library.
  The regular expression capture variables (`$1`, `$2`, etc.) are allowed.
<sup>[[link](#no-cryptic-perlisms)]</sup>

  ```Ruby
  # bad
  $:.unshift File.dirname(__FILE__)

  # good:  English not needed
  $LOAD_PATH.unshift File.dirname(__FILE__)

  # good
  require "English"
  $FIELD_SEPARATOR = ","
  numbers = "1,2,3".split

  # good:  regex capture variables
  "Gray, James" =~ /\A(\w+),\s*(\w+)\z/
  first, last = $2, $1
  ```

* <a name="parens-no-spaces"></a>
  Do not put a space between a method name and the opening parenthesis.
<sup>[[link](#parens-no-spaces)]</sup>

  ```Ruby
  # bad
  f (3 + 2) + 1

  # good
  f(3 + 2) + 1
  ```

* <a name="parens-as-args"></a>
  If the first argument to a method begins with an open parenthesis, always
  use parentheses in the method invocation. For example, write `f((3 + 2) + 1)`.
<sup>[[link](#parens-as-args)]</sup>

* <a name="always-warn-at-runtime"></a>
  Always run the Ruby interpreter with the `-w` option so it will warn you if
  you forget either of the rules above!
<sup>[[link](#always-warn-at-runtime)]</sup>

* <a name="no-nested-methods"></a>
  Do not use nested method definitions, use lambda instead.
  Nested method definitions actually produce methods in the same scope
  (e.g. class) as the outer method. Furthermore, the "nested method" will be
  redefined every time the method containing its definition is invoked.
<sup>[[link](#no-nested-methods)]</sup>

  ```Ruby
  # bad
  def foo(x)
    def bar(y)
      # body omitted
    end

    bar(x)
  end

  # good:  the same as the previous, but no bar redefinition on every foo call
  def bar(y)
    # body omitted
  end

  def foo(x)
    bar(x)
  end

  # also good
  def foo(x)
    bar = ->(y) { ... }
    bar.call(x)
  end
  ```

* <a name="lambda-multi-line"></a>
  Use the new lambda literal syntax for single line body blocks. Use the
  `lambda` method for multi-line blocks.
<sup>[[link](#lambda-multi-line)]</sup>

  ```Ruby
  # bad
  l = lambda { |a, b| a + b }
  l.call(1, 2)

  # passable:  awkward
  l = ->(a, b) {
    tmp = a * 7
    tmp * b / 50
  }

  # good
  l = ->(a, b) { a + b }
  l.call(1, 2)

  l = lambda { |a, b|
    tmp = a * 7
    tmp * b / 50
  }
  ```

* <a name="stabby-lambda-with-args"></a>
Don't omit the parameter parentheses when defining a stabby lambda with
parameters.
<sup>[[link](#stabby-lambda-with-args)]</sup>

  ```Ruby
  # bad
  l = ->x, y { something(x, y) }

  # good
  l = ->(x, y) { something(x, y) }
  ```

* <a name="stabby-lambda-no-args"></a>
Omit the parameter parentheses when defining a stabby lambda with
no parameters.
<sup>[[link](#stabby-lambda-no-args)]</sup>

  ```Ruby
  # bad
  l = ->() { something }

  # good
  l = -> { something }
  ```

* <a name="proc"></a>
  Prefer `proc` over `Proc.new`.
<sup>[[link](#proc)]</sup>

  ```Ruby
  # bad
  p = Proc.new do |n|
    puts n
  end

  # good
  p = proc do |n|
    puts n
  end
  ```

* <a name="proc-call"></a>
  Prefer `proc.call()` or `proc[]` over `proc.()` for both lambdas and procs.
<sup>[[link](#proc-call)]</sup>

  ```Ruby
  # bad:  uncommon syntax
  l = ->(v) do
    puts v
  end
  l.(1)

  # good
  l = ->(v) do
    puts v
  end
  l.call(1)

  # good:  can substitute for places that expect a Hash
  l = ->(v) do
    puts v
  end
  l[1]
  ```

* <a name="underscore-unused-vars"></a>
  Prefix with `_` unused block parameters and local variables. It's also
  acceptable to use just `_` (although it's a bit less descriptive). This
  convention is recognized by the Ruby interpreter and tools like RuboCop and
  will suppress their unused variable warnings.
<sup>[[link](#underscore-unused-vars)]</sup>

  ```Ruby
  # bad
  result = hash.map { |k, v| v + 1 }

  def something(x)
    unused_var, used_var = something_else(x)
    # ...
  end

  # good
  result = hash.map { |_k, v| v + 1 }

  def something(x)
    _unused_var, used_var = something_else(x)
    # ...
  end

  # good
  result = hash.map { |_, v| v + 1 }

  def something(x)
    _, used_var = something_else(x)
    # ...
  end
  ```

* <a name="global-stdout"></a>
  Use `$stdout/$stderr/$stdin` instead of `STDOUT/STDERR/STDIN`.
  `STDOUT/STDERR/STDIN` are constants, and while you can actually reassign
  (possibly to redirect some stream) constants in Ruby, you'll get an
  interpreter warning if you do so.
<sup>[[link](#global-stdout)]</sup>

* <a name="warn"></a>
  Use `warn` instead of `$stderr.puts`. Apart from being more concise and
  clear, `warn` allows you to suppress warnings if you need to (by setting the
  warn level to 0 via `-W0`).
<sup>[[link](#warn)]</sup>

* <a name="sprintf"></a>
  Favor the use of `sprintf` and its alias `format` over the fairly cryptic
  `String#%` method.
<sup>[[link](#sprintf)]</sup>

  ```Ruby
  # bad
  "%d %d" % [20, 10]
  # => "20 10"

  # good
  sprintf("%d %d", 20, 10)
  # => "20 10"

  # good
  sprintf("%{first} %{second}", first: 20, second: 10)
  # => "20 10"

  format("%d %d", 20, 10)
  # => "20 10"

  # good
  format("%{first} %{second}", first: 20, second: 10)
  # => "20 10"
  ```

* <a name="array-join"></a>
  Favor the use of `Array#join` over the fairly cryptic `Array#*` with
  a string argument.
<sup>[[link](#array-join)]</sup>

  ```Ruby
  # bad
  %w[one two three] * ", "
  # => "one, two, three"

  # good
  %w[one two three].join(", ")
  # => "one, two, three"
  ```

* <a name="splat-arrays"></a>
  Use `Array()` instead of an explicit `Array` check, when dealing with a
  variable you want to treat as an `Array`, but you're not certain it is one.
<sup>[[link](#splat-arrays)]</sup>

  ```Ruby
  # bad
  paths = [paths] unless paths.is_a?(Array)
  paths.each do |path|
    do_something(path)
  end

  # good
  Array(paths).each do |path|
    do_something(path)
  end
  ```

* <a name="ranges-or-between"></a>
  Use ranges or `Comparable#between?` instead of complex comparison logic when
  possible.
<sup>[[link](#ranges-or-between)]</sup>

  ```Ruby
  # bad
  do_something if x >= 1000 && x <= 2000

  # good
  do_something if (1000..2000).include?(x)

  # good
  do_something if x.between?(1000, 2000)
  ```

* <a name="predicate-methods"></a>
  Favor the use of predicate methods to explicit comparisons with `==`.
  Numeric comparisons are OK.
<sup>[[link](#predicate-methods)]</sup>

  ```Ruby
  # bad
  if x % 2 == 0
  end

  if x % 2 == 1
  end

  if x == nil
  end

  # good
  if x.even?
  end

  if x.odd?
  end

  if x.nil?
  end

  if x.zero?
  end

  if x == 0
  end
  ```

* <a name="no-non-nil-checks"></a>
  Don't do explicit non-`nil` checks unless you're dealing with boolean
  values.
<sup>[[link](#no-non-nil-checks)]</sup>

    ```ruby
    # bad
    do_something if !something.nil?
    do_something if something != nil

    # good
    do_something if something

    # good:  dealing with a boolean
    def value_set?
      !@some_boolean.nil?
    end
    ```

* <a name="no-BEGIN-blocks"></a>
  Avoid the use of `BEGIN` blocks outside of one-liners.
<sup>[[link](#no-BEGIN-blocks)]</sup>

* <a name="no-END-blocks"></a>
  Do not use `END` blocks outside of one-liners. Use `Kernel#at_exit` instead.
<sup>[[link](#no-END-blocks)]</sup>

  ```ruby
  # bad
  END { puts "Goodbye!" }

  # good
  at_exit do
    puts "Goodbye!"
  end
  ```

* <a name="no-flip-flops"></a>
  Avoid the use of flip-flops outside of one-liners.
<sup>[[link](#no-flip-flops)]</sup>

* <a name="no-nested-conditionals"></a>
  Avoid use of nested conditionals for flow of control.
<sup>[[link](#no-nested-conditionals)]</sup>

  Prefer a guard clause when you can assert invalid data. A guard clause
  is a conditional statement at the top of a function that bails out as
  soon as it can.

  ```Ruby
  # bad
  def compute_thing(thing)
    if thing[:foo]
      update_with_bar(thing)
      if thing[:foo][:bar]
        partial_compute(thing)
      else
        re_compute(thing)
      end
    end
  end

  # good
  def compute_thing(thing)
    return unless thing[:foo]
    update_with_bar(thing[:foo])
    return re_compute(thing) unless thing[:foo][:bar]
    partial_compute(thing)
  end
  ```

  Prefer `next` in loops instead of conditional blocks.

  ```Ruby
  # bad
  [0, 1, 2, 3].each do |item|
    if item > 1
      puts item
    end
  end

  # good
  [0, 1, 2, 3].each do |item|
    next unless item > 1
    puts item
  end
  ```

* <a name="map-find-select-reduce-size"></a>
  Prefer `map` over `collect`, `find` over `detect`, `select` over `find_all`,
  and `inject` over `reduce`. This is not a hard requirement; if the use of the
  alias enhances readability, it's ok to use it. The rhyming methods are
  inherited from Smalltalk and are not common in other programming languages.
  The reason the use of `select` is encouraged over `find_all` is that it goes
  together nicely with `reject` and its name is pretty self-explanatory.
  `inject` has been in Ruby longer and thus is just more widely used than
  `reduce`.
<sup>[[link](#map-find-select-reduce-size)]</sup>

* <a name="count-vs-size"></a>
  Don't use `count` as a substitute for `size`. For `Enumerable` objects other
  than `Array` it will iterate the entire collection in order to determine its
  size.
<sup>[[link](#count-vs-size)]</sup>

  ```Ruby
  # bad
  some_hash.count

  # good
  some_hash.size
  ```

* <a name="flat-map"></a>
  Use `flat_map` instead of `map` + `flatten`.  This does not apply for arrays
  with a depth greater than 2, i.e. if `users.first.songs == ["a", ["b", "c"]]`,
  then use `map + flatten` rather than `flat_map`.  `flat_map` flattens the
  array by 1, whereas `flatten` flattens it all the way.
<sup>[[link](#flat-map)]</sup>

  ```Ruby
  # bad
  all_songs = users.map(&:songs).flatten.uniq

  # good
  all_songs = users.flat_map(&:songs).uniq
  ```

* <a name="reverse-each"></a>
  Prefer `reverse_each` to `reverse.each` because some classes that `include
  Enumerable` will provide an efficient implementation. Even in the worst case
  where a class does not provide a specialized implementation, the general
  implementation inherited from `Enumerable` will be at least as efficient as
  using `reverse.each`.
<sup>[[link](#reverse-each)]</sup>

  ```Ruby
  # bad
  array.reverse.each do
    ...
  end

  # good
  array.reverse_each do
    ...
  end
  ```
