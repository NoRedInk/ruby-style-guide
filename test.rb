class Westerner
  def first_name
    @names.first
  end

  alias given_name first_name
end

class Fugitive < Westerner
  def first_name
    'Nobody'
  end

  alias_method :given_name, :first_name
end

p Fugitive.new.given_name
