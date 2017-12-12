$testInput = "pbga (66)
xhth (57)
ebii (61)
havc (66)
ktlj (57)
fwft (72) -> ktlj, cntj, xhth
qoyq (66)
padx (45) -> pbga, havc, qoyq
tknk (41) -> ugml, padx, fwft
jptl (61)
ugml (68) -> gyxo, ebii, jptl
gyxo (61)
cntj (57)"

$realInput = File.open("inputs/day07.txt").read

def printInstructions(instructions, index)
  puts "#{instructions.join(" ")} index: #{index}"
end

class Node
  def initialize(name, weight)
    @weight = weight
    @name = name
    @children = []
    @parent = nil
  end

  def weight
    @weight
  end

  def name
    @name
  end

  def children
    @children
  end

  def parent
    @parent
  end

  def set_parent(parent)
    @parent = parent
  end
end

def build_tree(input)

  programmes = input.lines.map { |l|
    words = l.split(/\W+/)
    [words[0], Node.new(words[0], words[1].to_i)]
  }.to_h

  input.lines.each do |l|
    words = l.split(/\W+/)
    name = words[0]
    words[2..-1].each do |child|
      programmes[child].set_parent(programmes[name])
      programmes[name].children << programmes[child]
    end
  end

  programmes
end

def get_root(input)
  nodes = build_tree(input)
  roots = nodes.select {|key,node| node.parent.nil? }

  puts "number of roots and first name and weight"
  puts roots.length

  root = roots[roots.keys[0]]
  puts root.name
  puts root.weight

  root
end

# get_root($testInput)
# get_root($realInput)

def weigh_tower(node)
  weight = node.weight + node.children.map {|child| weigh_tower(child) }.inject(0){|sum,x| sum + x }
  # puts "#{node.name} (#{node.weight}) tower weight: #{weight}"
  weight
end

def balance_inner(node)
  return if node.children.length == 0

  node.children.each do |child|
    balance_inner(child)
  end

  child_weights = node.children.map {|child| weigh_tower(child)}

  if child_weights.min != child_weights.max
    puts "!!!!!!!!!!!!!!!!!!!!"
    node.children.zip(child_weights).each do |zipped|
      puts "#{zipped[0].name} (#{zipped[0].weight}) tower weight: #{zipped[1]}"
    end

    exit 1
  end


end

def balance(input)
  root = get_root(input)
  balance_inner(root)
end

balance($realInput)
