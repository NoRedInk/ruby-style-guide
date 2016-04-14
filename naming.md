# Naming

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