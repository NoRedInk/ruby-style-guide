# Classes & Modules

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
