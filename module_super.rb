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

# puts Child.ancestors

p = Child.new
p.say