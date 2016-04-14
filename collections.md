# Collections

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
