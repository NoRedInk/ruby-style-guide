# Metaprogramming

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
