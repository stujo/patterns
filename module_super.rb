class Parent
  def say
    puts "In Parent"
  end
end

module A
  def say
    puts "In A"
    super
  end
end

module B
  def say
    puts "In B"
    super
  end
end

class Child < Parent
  include A, B
end

# class Parent
#   prepend A, B
# end

Parent.new.say
puts Parent.ancestors

Child.new.say
puts Child.ancestors