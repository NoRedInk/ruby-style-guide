array = %w[foo bar]

def do_something(*)
  
end

# bad (also a warning)
if v = array.grep(/foo/)
  do_something(v)
end

# good (MRI would still complain, but RuboCop won't)
if (v = array.grep(/foo/))
  do_something(v)
end

# good
v = array.grep(/foo/)
if v
  do_something(v)
end
