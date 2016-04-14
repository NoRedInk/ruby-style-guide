# Our Ruby Style Guide

This style guide is a minor refinement of [bbatsov's amazing work](https://github.com/bbatsov/ruby-style-guide).  In some places we are more opinionated.  In others we are less.  Likely the biggest difference between the two guides is that we are fans of using some simple conventions to add hints of intent for the readers of our code.

## Table of Contents

* [Syntax](#syntax)
* [Naming](#naming)
* [Comments](#comments)
  * [Comment Annotations](#comment-annotations)
* [Classes & Modules](#classes--modules)
* [Exceptions](#exceptions)
* [Collections](#collections)
* [Strings](#strings)
* [Regular Expressions](#regular-expressions)
* [Percent Literals](#percent-literals)
* [Metaprogramming](#metaprogramming)
* [Misc](#misc)


## Naming

* <a name="english-identifiers"></a>
  Name identifiers in English.
<sup>[[link](#english-identifiers)]</sup>

  ```Ruby
  # bad:  identifier using non-ascii characters
  заплата = 1_000

  # bad:  identifier is a Bulgarian word, written with Latin letters (instead of Cyrillic)
  zaplata = 1_000

  # good
  salary = 1_000
  ```

* <a name="snake-case-symbols-methods-vars"></a>
  Use `snake_case` for symbols, methods and variables.
<sup>[[link](#snake-case-symbols-methods-vars)]</sup>

  ```Ruby
  # bad
  :"some symbol"
  :SomeSymbol
  :someSymbol

  someVar = 5

  def someMethod
    ...
  end

  def SomeMethod
   ...
  end

  # good
  :some_symbol

  def some_method
    ...
  end
  ```

* <a name="camelcase-classes"></a>
  Use `CamelCase` for classes and modules.  (Keep acronyms like HTTP, RFC, XML
  uppercase.)

  **Note**:  The autoloader in Rails expects acronyms to have an initial capital
  only (`ApiWrapper` instead of `APIWrapper`), so it makes sense to use that
  style in Rails code.
<sup>[[link](#camelcase-classes)]</sup>

  ```Ruby
  # bad
  class Someclass
    ...
  end

  class Some_Class
    ...
  end

  class SomeXml
    ...
  end

  class XmlSomething
    ...
  end

  # good
  class SomeClass
    ...
  end

  class SomeXML
    ...
  end

  class XMLSomething
    ...
  end
  ```

* <a name="snake-case-files"></a>
  Use `snake_case` for naming files, e.g. `hello_world.rb`.
<sup>[[link](#snake-case-files)]</sup>

* <a name="snake-case-dirs"></a>
  Use `snake_case` for naming directories, e.g.
  `lib/hello_world/hello_world.rb`.
<sup>[[link](#snake-case-dirs)]</sup>

* <a name="one-class-per-file"></a>
  Aim to have just a single class/module per source file. Name the file name
  as the class/module, but replacing CamelCase with snake_case.
<sup>[[link](#one-class-per-file)]</sup>

* <a name="screaming-snake-case"></a>
  Use `SCREAMING_SNAKE_CASE` for other constants.
<sup>[[link](#screaming-snake-case)]</sup>

  ```Ruby
  # bad
  SomeConst = 5

  # good
  SOME_CONST = 5
  ```

* <a name="bool-methods-qmark"></a>
  The names of predicate methods (methods that return a boolean value) should
  end in a question mark.  (i.e. `Array#empty?`). Methods that don't return a
  boolean, shouldn't end in a question mark.
<sup>[[link](#bool-methods-qmark)]</sup>

* <a name="dangerous-method-bang"></a>
  The names of potentially _dangerous_ methods (i.e. methods that modify
  `self` or the arguments, `exit!` (doesn't run the finalizers like `exit`
  does), etc.) should end with an exclamation mark if there exists a safe
  version of that _dangerous_ method.

  **Note**:  Rails mostly ignores this convention.  In Rails related code, `!`
  is often added to methods that modify the receiver.  These method may or may
  not have a non-modifying version.
<sup>[[link](#dangerous-method-bang)]</sup>

  ```Ruby
  # bad:  there is no matching 'safe' method
  class Person
    def update!
    end
  end

  # good
  class Person
    def update
    end
  end

  # good
  class Person
    def update!
    end

    def update
    end
  end
  ```

* <a name="safe-because-unsafe"></a>
  Define the non-bang (safe) method in terms of the bang (dangerous) one if
  possible.
<sup>[[link](#safe-because-unsafe)]</sup>

  ```Ruby
  class Array
    def flatten_once!
      res = []

      each do |e|
        [*e].each { |f| res << f }
      end

      replace(res)
    end

    def flatten_once
      dup.flatten_once!
    end
  end
  ```

* <a name="other-arg"></a>
  When defining binary operators, name the parameter `other`(`<<` and `[]` are
  exceptions to the rule, since their semantics are different).
<sup>[[link](#other-arg)]</sup>

  ```Ruby
  def +(other)
    # body omitted
  end
  ```

## Comments

* <a name="no-comments"></a>
  Write self-documenting code and ignore the rest of this section. Seriously!
<sup>[[link](#no-comments)]</sup>

* <a name="english-comments"></a>
  Write comments in English.
<sup>[[link](#english-comments)]</sup>

* <a name="hash-space"></a>
  Use one space between the leading `#` character of the comment and the text
  of the comment.
<sup>[[link](#hash-space)]</sup>

* <a name="english-syntax"></a>
  Longer comments should use proper capitalization and punctuation.
<sup>[[link](#english-syntax)]</sup>

* <a name="no-superfluous-comments"></a>
  Avoid superfluous comments.
<sup>[[link](#no-superfluous-comments)]</sup>

  ```Ruby
  # bad
  counter += 1 # Increments counter by one.
  ```

* <a name="comment-upkeep"></a>
  Keep existing comments up-to-date. An outdated comment is worse than no
  comment at all.
<sup>[[link](#comment-upkeep)]</sup>

* <a name="refactor-dont-comment"></a>
  Avoid writing comments to explain bad code. Refactor the code to make it
  self-explanatory.
<sup>[[link](#refactor-dont-comment)]</sup>

### Comment Annotations

* <a name="annotate-above"></a>
  Annotations should usually be written on the line immediately above the
  relevant code.
<sup>[[link](#annotate-above)]</sup>

* <a name="annotate-keywords"></a>
  The annotation keyword is followed by a colon and a space, then a note
  describing the problem.
<sup>[[link](#annotate-keywords)]</sup>

* <a name="rare-eol-annotations"></a>
  In cases where the problem is so obvious that any documentation would be
  redundant, annotations may be left at the end of the offending line with no
  note. This usage should be the exception and not the rule.
<sup>[[link](#rare-eol-annotations)]</sup>

  ```Ruby
  def bar
    sleep 100 # OPTIMIZE
  end
  ```

* <a name="todo"></a>
  Use `TODO` to note missing features or functionality that should be added at
  a later date.
<sup>[[link](#todo)]</sup>

* <a name="fixme"></a>
  Use `FIXME` to note broken code that needs to be fixed.
<sup>[[link](#fixme)]</sup>

* <a name="optimize"></a>
  Use `OPTIMIZE` to note slow or inefficient code that may cause performance
  problems.
<sup>[[link](#optimize)]</sup>

* <a name="hack"></a>
  Use `HACK` to note code smells where questionable coding practices were used
  and should be refactored away.
<sup>[[link](#hack)]</sup>

* <a name="review"></a>
  Use `REVIEW` to note anything that should be looked at to confirm it is
  working as intended. For example: `REVIEW: Are we sure this is how the client
  does X currently?`
<sup>[[link](#review)]</sup>

* <a name="document-annotations"></a>
  Use other custom annotation keywords if it feels appropriate, but be sure to
  document them in your project's `README` or similar.
<sup>[[link](#document-annotations)]</sup>

## Classes & Modules

* <a name="consistent-classes"></a>
  Use a consistent structure in your class definitions.
<sup>[[link](#consistent-classes)]</sup>

  ```Ruby
  class Person
    # extend and include go first
    extend SomeModule
    include AnotherModule

    # inner classes
    CustomErrorKlass = Class.new(StandardError)

    # constants are next
    SOME_CONSTANT = 20

    # afterwards we have attribute macros
    attr_reader :name

    # followed by other macros (if any)
    validates :name

    # public class methods are next in line
    def self.some_method
    end

    # initialization goes between class methods and other instance methods
    def initialize
    end

    # followed by other public instance methods
    def some_method
    end

    # protected and private methods are grouped near the end
    protected

    def some_protected_method
    end

    private

    def some_private_method
    end
  end
  ```

* <a name="file-classes"></a>
  Don't nest multi line classes within classes. Try to have such nested
  classes each in their own file in a folder named like the containing class.
<sup>[[link](#file-classes)]</sup>

  ```Ruby
  # bad

  # foo.rb
  class Foo
    class Bar
      # 30 methods inside
    end

    class Car
      # 20 methods inside
    end

    # 30 methods inside
  end

  # good

  # foo.rb
  class Foo
    # 30 methods inside
  end

  # foo/bar.rb
  class Foo
    class Bar
      # 30 methods inside
    end
  end

  # foo/car.rb
  class Foo
    class Car
      # 20 methods inside
    end
  end
  ```

* <a name="modules-vs-classes"></a>
  Prefer modules to classes with only class methods. Classes should be used
  only when it makes sense to create instances out of them.
<sup>[[link](#modules-vs-classes)]</sup>

  ```Ruby
  # bad
  class SomeClass
    def self.some_method
      # body omitted
    end

    def self.some_other_method
    end
  end

  # good
  module SomeModule
    module_function

    def some_method
      # body omitted
    end

    def some_other_method
    end
  end
  ```

* <a name="module-function"></a>
  Favor the use of `module_function` over `extend self` when you want to turn
  a module's instance methods into class methods.
<sup>[[link](#module-function)]</sup>

  ```Ruby
  # bad
  module Utilities
    extend self

    def parse_something(string)
      # do stuff here
    end

    def other_utility_method(number, string)
      # do some more stuff
    end
  end

  # good
  module Utilities
    module_function

    def parse_something(string)
      # do stuff here
    end

    def other_utility_method(number, string)
      # do some more stuff
    end
  end
  ```

* <a name="liskov"></a>
  When designing class hierarchies make sure that they conform to the [Liskov
  Substitution
  Principle](https://en.wikipedia.org/wiki/Liskov_substitution_principle).
<sup>[[link](#liskov)]</sup>

* <a name="solid-design"></a>
  Try to make your classes as
  [SOLID](https://en.wikipedia.org/wiki/SOLID_\(object-oriented_design\)) as
  possible.
<sup>[[link](#solid-design)]</sup>

* <a name="define-to-s"></a>
  Always supply a proper `to_s` method for classes that represent domain
  objects.
<sup>[[link](#define-to-s)]</sup>

  ```Ruby
  class Person
    attr_reader :first_name, :last_name

    def initialize(first_name, last_name)
      @first_name = first_name
      @last_name = last_name
    end

    def to_s
      "#{@first_name} #{@last_name}"
    end
  end
  ```

* <a name="attr_family"></a>
  Use the `attr` family of functions to define trivial accessors or mutators.
<sup>[[link](#attr_family)]</sup>

  ```Ruby
  # bad
  class Person
    def initialize(first_name, last_name)
      @first_name = first_name
      @last_name = last_name
    end

    def first_name
      @first_name
    end

    def last_name
      @last_name
    end
  end

  # good
  class Person
    attr_reader :first_name, :last_name

    def initialize(first_name, last_name)
      @first_name = first_name
      @last_name = last_name
    end
  end
  ```

* <a name="attr"></a>
  Avoid the use of `attr` (now undocumented). Use `attr_reader` and
  `attr_accessor` instead.
<sup>[[link](#attr)]</sup>

  ```Ruby
  # bad:  creates a single attribute accessor
  attr :something, true    # behaves as attr_accessor
  attr :one, :two, :three  # behaves as attr_reader

  # good
  attr_accessor :something
  attr_reader :one, :two, :three
  ```

* <a name="struct-new"></a>
  Consider using `Struct.new`, which defines the trivial accessors,
  constructor and comparison operators for you. (Just be aware that `Struct`
  adds several convenience methods that you may not want in some cases.
  An example is that you would prefer to know that some data class
  is immutable and will not change, so the setters that `Struct`
  automatically creates for all fields would be inappropriate.)
<sup>[[link](#struct-new)]</sup>

  ```Ruby
  # good
  class Person
    attr_accessor :first_name, :last_name

    def initialize(first_name, last_name)
      @first_name = first_name
      @last_name = last_name
    end
  end

  # good
  Person = Struct.new(:first_name, :last_name)
  ````

* <a name="no-extend-struct-new"></a>
  Don't extend an instance initialized by `Struct.new`. Extending it introduces
  a superfluous class level and may also introduce weird errors if the file is
  required multiple times.
<sup>[[link](#no-extend-struct-new)]</sup>

  ```Ruby
  # bad
  class Person < Struct.new(:first_name, :last_name)
    # any other methods...
  end

  # good
  Person = Struct.new(:first_name, :last_name) do
    # any other methods...
  end
  ````

* <a name="factory-methods"></a>
  Consider adding factory methods to provide additional sensible ways to
  create instances of a particular class.
<sup>[[link](#factory-methods)]</sup>

  ```Ruby
  class Person
    def self.create(options_hash)
      # body omitted
    end
  end
  ```

* <a name="duck-typing"></a>
  Prefer [duck-typing](https://en.wikipedia.org/wiki/Duck_typing) over
  inheritance.
<sup>[[link](#duck-typing)]</sup>

  ```Ruby
  # bad
  class Animal
    # abstract method
    def speak
    end
  end

  # extend superclass
  class Duck < Animal
    def speak
      puts "Quack! Quack"
    end
  end

  # extend superclass
  class Dog < Animal
    def speak
      puts "Bau! Bau!"
    end
  end

  # good
  class Duck
    def speak
      puts "Quack! Quack"
    end
  end

  class Dog
    def speak
      puts "Bau! Bau!"
    end
  end
  ```

* <a name="no-class-vars"></a>
  Avoid the usage of class (`@@`) variables due to their "nasty" behavior in
  inheritance.
<sup>[[link](#no-class-vars)]</sup>

  ```Ruby
  class Parent
    @@class_var = "parent"

    def self.print_class_var
      puts @@class_var
    end
  end

  class Child < Parent
    @@class_var = "child"
  end

  Parent.print_class_var # => will print "child"
  ```

  As you can see all the classes in a class hierarchy actually share one
  class variable. Class instance variables should usually be preferred
  over class variables.

* <a name="visibility"></a>
  Assign proper visibility levels to methods (`private`, `protected`) in
  accordance with their intended usage. Don't go off leaving everything `public`
  (which is the default).
<sup>[[link](#visibility)]</sup>

* <a name="indent-public-private-protected"></a>
  Indent the `public`, `protected`, and `private` methods as much as the method
  definitions they apply to. Leave one blank line above the visibility modifier
  and one blank line below in order to emphasize that it applies to all methods
  below it.
<sup>[[link](#indent-public-private-protected)]</sup>

  ```Ruby
  class SomeClass
    def public_method
      # ...
    end

    private

    def private_method
      # ...
    end

    def another_private_method
      # ...
    end
  end
  ```

* <a name="def-self-class-methods"></a>
  Use `def self.method` to define class methods. This makes the code
  easier to refactor since the class name is not repeated.
<sup>[[link](#def-self-class-methods)]</sup>

  ```Ruby
  class TestClass
    # bad
    def TestClass.some_method
      # body omitted
    end

    # bad:  It's easy to miss that later methods, like second_method_etc(), are
    # under this new scope.  Indention may be your only clue if `class << self`
    # is off screen.
    class << self
      def first_method
        # body omitted
      end

      def second_method_etc
        # body omitted
      end
    end

    # good
    def self.some_other_method
      # body omitted
    end
  end
  ```

* <a name="alias-method"></a>
  Prefer `alias_method` when aliasing methods.  The alternative, `alias`, is a
  keyword with unusual syntax.
<sup>[[link](#alias-method)]</sup>

  ```Ruby
  class Westerner
    def first_name
      @names.first
    end
    alias_method :given_name, :first_name
  end
  ```

  Be aware of how Ruby handles aliases: an alias is actually just a copy of the
  method that was made at the time the alias was defined; it is not dispatched
  dynamically.  This matters in cases like inheritance:

  ```Ruby
  class Fugitive < Westerner
    def first_name
      "Nobody"
    end
  end
  ```

  In this example, `Fugitive#given_name` would still call the original
  `Westerner#first_name` method, not `Fugitive#first_name`. To override the
  behavior of `Fugitive#given_name` as well, you'd have to redefine it in the
  derived class.

  ```Ruby
  class Fugitive < Westerner
    def first_name
      "Nobody"
    end
    alias_method :given_name, :first_name
  end
  ```

* <a name="nested-modules-and-classes"></a>
  When creating new nested modules or classes, avoid `::`. Only use `::` when referring to modules or classes in other files (see: [double colons](#double-colons)). When loading the file, if the left side of the `::` isn't defined, Ruby will choke. <sup>[[link](#nested-modules-and-classes)]</sup>

  ```Ruby
  # bad
  class ParentModule::NaughtyInnerChildClass; end

  # good
  module ParentModule
    class WellBehavedChildClass; end
  end
  ```

## Exceptions

* <a name="fail-method"></a>
  Signal exceptions using the `fail` method. Use `raise` only when catching an
  exception and re-raising it (because here you're not failing, but explicitly
  and purposefully raising an exception).
<sup>[[link](#fail-method)]</sup>

  ```Ruby
  begin
    fail "Oops"
  rescue => error
    raise if error.message != "Oops"
  end
  ```

* <a name="no-explicit-runtimeerror"></a>
  Don't specify `RuntimeError` explicitly in the two argument version of
  `fail/raise`.
<sup>[[link](#no-explicit-runtimeerror)]</sup>

  ```Ruby
  # bad
  fail RuntimeError, "message"

  # good:  signals a RuntimeError by default
  fail "message"
  ```

* <a name="exception-class-messages"></a>
  Prefer supplying an exception class and a message as two separate arguments
  to `fail/raise`, instead of an exception instance.
<sup>[[link](#exception-class-messages)]</sup>

  ```Ruby
  # bad
  fail SomeException.new("message")
  # Note that there is no way to do `fail SomeException.new("message"), backtrace`.

  # good
  fail SomeException, "message"
  # Consistent with `fail SomeException, "message", backtrace`.
  ```

* <a name="no-return-ensure"></a>
  Do not return from an `ensure` block. If you explicitly return from a method
  inside an `ensure` block, the return will take precedence over any exception
  being raised, and the method will return as if no exception had been raised at
  all. In effect, the exception will be silently thrown away.
<sup>[[link](#no-return-ensure)]</sup>

  ```Ruby
  def foo
    fail
  ensure
    return "very bad idea"
  end
  ```

* <a name="begin-implicit"></a>
  Use *implicit begin blocks* where possible.
<sup>[[link](#begin-implicit)]</sup>

  ```Ruby
  # bad
  def foo
    begin
      # main logic goes here
    rescue
      # failure handling goes here
    end
  end

  # good
  def foo
    # main logic goes here
  rescue
    # failure handling goes here
  end
  ```

* <a name="contingency-methods"></a>
  Mitigate the proliferation of `begin` blocks by using *contingency methods*
  (a term coined by Avdi Grimm).
<sup>[[link](#contingency-methods)]</sup>

  ```Ruby
  # bad
  begin
    something_that_might_fail
  rescue IOError
    # handle IOError
  end

  begin
    something_else_that_might_fail
  rescue IOError
    # handle IOError
  end

  # good
  def with_io_error_handling
     yield
  rescue IOError
    # handle IOError
  end

  with_io_error_handling { something_that_might_fail }

  with_io_error_handling { something_else_that_might_fail }
  ```

* <a name="dont-hide-exceptions"></a>
  Don't suppress exceptions.
<sup>[[link](#dont-hide-exceptions)]</sup>

  ```Ruby
  # bad
  begin
    # an exception occurs here
  rescue SomeError
    # the rescue clause does absolutely nothing
  end

  # bad
  do_something rescue nil
  ```

* <a name="no-rescue-modifiers"></a>
  Avoid using `rescue` in its modifier form. An exception can be made for
  assignment of the error.
<sup>[[link](#no-rescue-modifiers)]</sup>

  ```Ruby
  # bad:  this catches exceptions of StandardError class and its descendant classes
  read_file rescue handle_error($!)

  # good:  this catches only the exceptions of Errno::ENOENT class and its descendant classes
  def foo
    read_file
  rescue Errno::ENOENT => ex
    handle_error(ex)
  end

  # passable:  assigning the error
  content_or_error = read_file rescue $!
  ```

* <a name="no-exceptional-flows"></a>
  Don't use exceptions for flow of control.
<sup>[[link](#no-exceptional-flows)]</sup>

  ```Ruby
  # bad
  begin
    n / d
  rescue ZeroDivisionError
    puts "Cannot divide by 0!"
  end

  # good
  if d.zero?
    puts "Cannot divide by 0!"
  else
    n / d
  end
  ```

* <a name="no-blind-rescues"></a>
  Avoid rescuing the `Exception` class.  This will trap signals and calls to
  `exit`, requiring you to `kill -9` the process.
<sup>[[link](#no-blind-rescues)]</sup>

  ```Ruby
  # bad
  begin
    # calls to exit and kill signals will be caught (except kill -9)
    exit
  rescue Exception
    puts "you didn't really want to exit, right?"
    # exception handling
  end

  # good
  begin
    # a blind rescue rescues from StandardError, not Exception
  rescue => e
    # exception handling
  end

  # also good
  begin
    # an exception occurs here
  rescue StandardError => e
    # exception handling
  end
  ```

* <a name="exception-ordering"></a>
  Put more specific exceptions higher up the rescue chain, otherwise they'll
  never be rescued from.
<sup>[[link](#exception-ordering)]</sup>

  ```Ruby
  # bad
  begin
    # some code
  rescue StandardError => e
    # some handling
  rescue IOError => e
    # some handling that will never be executed
  end

  # good
  begin
    # some code
  rescue IOError => e
    # some handling
  rescue StandardError => e
    # some handling
  end
  ```

* <a name="release-resources"></a>
  Release external resources obtained by your program in an `ensure` block.
<sup>[[link](#release-resources)]</sup>

  ```Ruby
  f = File.open("testfile")
  begin
    # .. process
  rescue
    # .. handle error
  ensure
    f.close if f
  end
  ```

* <a name="auto-release-resources"></a>
Use versions of resource obtaining methods that do automatic
resource cleanup when possible.
<sup>[[link](#auto-release-resources)]</sup>

  ```Ruby
  # bad:  you need to close the file descriptor explicitly
  f = File.open("testfile")
    # ...
  f.close

  # good:  the file descriptor is closed automatically
  File.open("testfile") do |f|
    # ...
  end
  ```

## Collections

* <a name="literal-array-hash"></a>
  Prefer literal array and hash creation notation (unless you need to pass
  parameters to their constructors, that is).
<sup>[[link](#literal-array-hash)]</sup>

  ```Ruby
  # bad
  arr = Array.new
  hash = Hash.new

  # good
  arr = [ ]
  hash = { }
  ```

* <a name="percent-w"></a>
  Prefer `%w` to the literal array syntax when you need an array of words
  (non-empty strings without spaces and special characters in them).
<sup>[[link](#percent-w)]</sup>

  ```Ruby
  # bad
  STATES = ["draft", "open", "closed"]

  # good
  STATES = %w[draft open closed]
  ```

* <a name="percent-i"></a>
  Prefer `%i` to the literal array syntax when you need an array of symbols
  (and you don't need to maintain Ruby 1.9 compatibility).
<sup>[[link](#percent-i)]</sup>

  ```Ruby
  # bad
  STATES = [:draft, :open, :closed]

  # good
  STATES = %i[draft open closed]
  ```

* <a name="no-trailing-array-commas"></a>
  Avoid comma after the last item of an `Array` or `Hash` when the items are not
  on separate lines.
<sup>[[link](#no-trailing-array-commas)]</sup>

  ```Ruby
  # good:  easier to move/add/remove items
  VALUES = [
             1001,
             2020,
             3333,
           ]

  # bad
  VALUES = [1001, 2020, 3333, ]

  # good
  VALUES = [1001, 2020, 3333]
  ```

* <a name="no-gappy-arrays"></a>
  Avoid the creation of huge gaps in arrays.
<sup>[[link](#no-gappy-arrays)]</sup>

  ```Ruby
  arr = []
  arr[100] = 1 # now you have an array with lots of nils
  ```

* <a name="first-and-last"></a>
  When accessing the first or last element from an array, prefer `first` or
  `last` over `[0]` or `[-1]`.
<sup>[[link](#first-and-last)]</sup>

* <a name="set-vs-array"></a>
  Use `Set` instead of `Array` when dealing with unique elements. `Set`
  implements a collection of unordered values with no duplicates. This is a
  hybrid of `Array`'s intuitive inter-operation facilities and `Hash`'s fast
  lookup.
<sup>[[link](#set-vs-array)]</sup>

* <a name="symbols-as-keys"></a>
  Prefer symbols instead of strings as hash keys.
<sup>[[link](#symbols-as-keys)]</sup>

  ```Ruby
  # bad
  hash = {"one" => 1, "two" => 2, "three" => 3}

  # good
  hash = {one: 1, two: 2, three: 3}
  ```

* <a name="no-mutable-keys"></a>
  Avoid the use of mutable objects as hash keys.
<sup>[[link](#no-mutable-keys)]</sup>

* <a name="hash-literals"></a>
  Use the Ruby 1.9 hash literal syntax when your hash keys are symbols.
<sup>[[link](#hash-literals)]</sup>

  ```Ruby
  # bad
  hash = {:one => 1, :two => 2, :three => 3}

  # good
  hash = {one: 1, two: 2, three: 3}
  ```

* <a name="no-mixed-hash-syntaces"></a>
  Don't mix the Ruby 1.9 hash syntax with hash rockets in the same hash
  literal. When you've got keys that are not symbols stick to the hash rockets
  syntax.
<sup>[[link](#no-mixed-hash-syntaces)]</sup>

  ```Ruby
  # bad
  {a: 1, "b" => 2}

  # good
  {:a => 1, "b" => 2}
  ```

* <a name="hash-key"></a>
  Use `Hash#key?` instead of `Hash#has_key?` and `Hash#value?` instead of
  `Hash#has_value?`. As noted
  [here](http://blade.nagaokaut.ac.jp/cgi-bin/scat.rb/ruby/ruby-core/43765) by
  Matz, the longer forms are considered deprecated.
<sup>[[link](#hash-key)]</sup>

  ```Ruby
  # bad
  hash.has_key?(:test)
  hash.has_value?(value)

  # good
  hash.key?(:test)  # or hash.include?(:test)
  hash.value?(value)
  ```

* <a name="hash-fetch"></a>
  Use `Hash#fetch` when dealing with hash keys that should be present.
<sup>[[link](#hash-fetch)]</sup>

  ```Ruby
  heroes = {batman: "Bruce Wayne", superman: "Clark Kent"}
  # bad:  if we make a mistake we might not spot it right away
  heroes[:batman] # => "Bruce Wayne"
  heroes[:supermann] # => nil

  # good:  fetch raises a KeyError making the problem obvious
  heroes.fetch(:supermann)
  ```

* <a name="hash-fetch-defaults"></a>
  Introduce default values for hash keys via `Hash#fetch` as opposed to using
  custom logic.
<sup>[[link](#hash-fetch-defaults)]</sup>

  ```Ruby
  batman = {name: "Bruce Wayne", is_evil: false}

  # bad:  if we just use || operator with falsy value we won't get the expected result
  batman[:is_evil] || true # => true

  # good:  fetch work correctly with falsy values
  batman.fetch(:is_evil) { true } # => false
  ```

* <a name="use-hash-blocks"></a>
  Prefer the use of the block instead of the default value in `Hash#fetch`.
  <sup>[[link](#use-hash-blocks)]</sup>

  ```Ruby
  batman = {name: "Bruce Wayne"}

  # bad:  if we use the default value, we eager evaluate it
  # so it can slow the program down if done multiple times
  batman.fetch(:powers, obtain_batman_powers) # obtain_batman_powers is an expensive call

  # good:  blocks are lazy evaluated, so only triggered in case of KeyError exception
  batman.fetch(:powers) { obtain_batman_powers }
  ```

* <a name="hash-values-at"></a>
  Use `Hash#values_at` when you need to retrieve several values consecutively
  from a hash.
<sup>[[link](#hash-values-at)]</sup>

  ```Ruby
  # bad
  email = data["email"]
  username = data["nickname"]

  # good
  email, username = data.values_at("email", "nickname")
  ```

* <a name="ordered-hashes"></a>
  Rely on the fact that as of Ruby 1.9 hashes are ordered.
<sup>[[link](#ordered-hashes)]</sup>

* <a name="no-modifying-collections"></a>
  Do not modify a collection while traversing it.
<sup>[[link](#no-modifying-collections)]</sup>

* <a name="accessing-elements-directly"></a>
  When accessing elements of a collection, avoid direct access
  via `[n]` by using an alternate form of the reader method if it is
  supplied. This guards you from calling `[]` on `nil`.
<sup>[[link](#accessing-elements-directly)]</sup>

  ```Ruby
  # bad
  Regexp.last_match[1]

  # good
  Regexp.last_match(1)
  ```

* <a name="provide-alternate-accessor-to-collections"></a>
  When providing an accessor for a collection, provide an alternate form
  to save users from checking for `nil` before accessing an element in
  the collection.
<sup>[[link](#provide-alternate-accessor-to-collections)]</sup>

  ```Ruby
  # bad
  def awesome_things
    @awesome_things
  end

  # good
  def awesome_things(index = nil)
    if index && @awesome_things
      @awesome_things[index]
    else
      @awesome_things
    end
  end
  ```

## Strings

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

## Regular Expressions

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

## Percent Literals

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

## Metaprogramming

* <a name="no-needless-metaprogramming"></a>
  Avoid needless metaprogramming.
<sup>[[link](#no-needless-metaprogramming)]</sup>

* <a name="no-monkey-patching"></a>
  Do not mess around in core classes when writing libraries.  (Do not
  monkey-patch them.)
<sup>[[link](#no-monkey-patching)]</sup>

* <a name="block-class-eval"></a>
  The block form of `class_eval` is preferable to the string-interpolated
  form.
<sup>[[link](#block-class-eval)]</sup>

  - when you use the string-interpolated form, always supply `__FILE__`
  and `__LINE__`, so that your backtraces make sense:

    ```ruby
    class_eval "def use_relative_model_naming?; true; end", __FILE__, __LINE__
    ```

  - `define_method` is preferable to `class_eval do def ... end`

* <a name="eval-comment-docs"></a>
  When using `class_eval` (or other `eval`) with string interpolation, add a
  comment block showing its appearance if interpolated (a practice used in Rails
  code):
<sup>[[link](#eval-comment-docs)]</sup>

  ```ruby
  # from activesupport/lib/active_support/core_ext/string/output_safety.rb
  UNSAFE_STRING_METHODS.each do |unsafe_method|
    if "String".respond_to?(unsafe_method)
      class_eval <<-EOT, __FILE__, __LINE__ + 1
        def #{unsafe_method}(*params, &block)       # def capitalize(*params, &block)
          to_str.#{unsafe_method}(*params, &block)  #   to_str.capitalize(*params, &block)
        end                                         # end

        def #{unsafe_method}!(*params)              # def capitalize!(*params)
          @dirty = true                             #   @dirty = true
          super                                     #   super
        end                                         # end
      EOT
    end
  end
  ```

* <a name="no-method-missing"></a>
  Avoid using `method_missing` for metaprogramming because backtraces become
  messy, the behavior is not listed in `#methods`, and misspelled method calls
  might silently work, e.g. `nukes.launch_state = false`. Consider using
  delegation, proxy, or `define_method` instead. If you must use
  `method_missing`:
<sup>[[link](#no-method-missing)]</sup>

  - Be sure to [also define `respond_to_missing?`](http://blog.marc-andre.ca/2010/11/methodmissing-politely.html)
  - Only catch methods with a well-defined prefix, such as `find_by_*` -- make your code as assertive as possible.
  - Call `super` at the end of your statement
  - Delegate to assertive, non-magical methods:

    ```ruby
    # bad
    def method_missing?(meth, *params, &block)
      if /^find_by_(?<prop>.*)/ =~ meth
        # ... lots of code to do a find_by
      else
        super
      end
    end

    # good
    def method_missing?(meth, *params, &block)
      if /^find_by_(?<prop>.*)/ =~ meth
        find_by(prop, *params, &block)
      else
        super
      end
    end

    # best of all, though, would to define_method as each findable attribute is declared
    ```

* <a name="prefer-public-send"></a>
  Prefer `public_send` over `send` so as not to circumvent `private`/`protected` visibility.
<sup>[[link](#prefer-public-send)]</sup>

  ```ruby
  # We have  an ActiveModel Organization that includes concern Activatable
  module Activatable
    extend ActiveSupport::Concern

    included do
      before_create :create_token
    end

    private

    def reset_token
      ...
    end

    def create_token
      ...
    end

    def activate!
      ...
    end
  end

  class Organization < ActiveRecord::Base
    include Activatable
  end

  linux_organization = Organization.find(...)
  # bad:  violates privacy
  linux_organization.send(:reset_token)
  # good:  should throw an exception
  linux_organization.public_send(:reset_token)
  ```

* <a name="prefer-__send__"></a>
  Prefer `__send__` over `send`, as `send` may overlap with existing methods.
<sup>[[link](#prefer-__send__)]</sup>

  ```ruby
  require "socket"

  u1 = UDPSocket.new
  u1.bind("127.0.0.1", 4913)
  u2 = UDPSocket.new
  u2.connect("127.0.0.1", 4913)
  # Won't send a message to the receiver obj.
  # Instead it will send a message via UDP socket.
  u2.send :sleep, 0
  # Will actually send a message to the receiver obj.
  u2.__send__ ...
  ```

## Misc

* <a name="always-warn"></a>
  Write `ruby -w` safe code.
<sup>[[link](#always-warn)]</sup>

* <a name="no-optional-hash-params"></a>
  Avoid hashes as optional parameters. Does the method do too much? (Object
  initializers are exceptions for this rule).
<sup>[[link](#no-optional-hash-params)]</sup>

* <a name="short-methods"></a>
  Avoid methods longer than 10 LOC (lines of code). Ideally, most methods will
  be shorter than 5 LOC. Empty lines do not contribute to the relevant LOC.
<sup>[[link](#short-methods)]</sup>

* <a name="too-many-params"></a>
  Avoid parameter lists longer than three or four parameters.
<sup>[[link](#too-many-params)]</sup>

* <a name="private-global-methods"></a>
  If you really need "global" methods, add them to Kernel and make them
  private.
<sup>[[link](#private-global-methods)]</sup>

* <a name="instance-vars"></a>
  Use module instance variables instead of global variables.
<sup>[[link](#instance-vars)]</sup>

  ```Ruby
  # bad
  $foo_bar = 1

  # good
  module Foo
    class << self
      attr_accessor :bar
    end
  end

  Foo.bar = 1
  ```

* <a name="optionparser"></a>
  Use `OptionParser` for parsing complex command line options and `ruby -s`
  for trivial command line options.
<sup>[[link](#optionparser)]</sup>

* <a name="time-now"></a>
  Prefer `Time.now` over `Time.new` when retrieving the current system time.
<sup>[[link](#time-now)]</sup>

* <a name="functional-code"></a>
  Code in a functional way, avoiding mutation when that makes sense.
<sup>[[link](#functional-code)]</sup>

* <a name="no-param-mutations"></a>
  Do not mutate parameters unless that is the purpose of the method.
<sup>[[link](#no-param-mutations)]</sup>

* <a name="three-is-the-number-thou-shalt-count"></a>
  Avoid more than three levels of block nesting.
<sup>[[link](#three-is-the-number-thou-shalt-count)]</sup>

* <a name="be-consistent"></a>
  Be consistent. In an ideal world, be consistent with these guidelines.
<sup>[[link](#be-consistent)]</sup>

* <a name="common-sense"></a>
  Use common sense.
<sup>[[link](#common-sense)]</sup>

# License

![Creative Commons License](http://i.creativecommons.org/l/by/3.0/88x31.png)
This work is licensed under a [Creative Commons Attribution 3.0 Unported License](http://creativecommons.org/licenses/by/3.0/deed.en_US)
