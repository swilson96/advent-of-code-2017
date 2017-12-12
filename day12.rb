require 'set'

class Program
  def initialize(input)
    words = input.split(/\W+/)
    #puts "#{input} parsed to: #{words.join(',')}"
    @name = words[0].to_i
    @neighbour_names = words[1..-1].map {|w| w.to_i}
  end

  def name
    @name
  end

  def neighbour_names
    @neighbour_names
  end
end

class Day12
  def size_of_group_zero input
    return build_group(0, input).size
  end

  def build_group name, input

    programs = input.lines
                   .map {|l| Program.new(l)}
                   .map {|p| [p.name, p]}
                   .to_h

    build_group_from_progs name, programs
  end

  def build_group_from_progs name, programs
    group = Set.new
    names_to_check = Set.new [name]

    while names_to_check.any?
      group.merge names_to_check
      names_to_check = Set.new(names_to_check.flat_map {|n| programs[n].neighbour_names })
                           .difference(group)
    end

    group
  end

  def count_groups input
    programs = input.lines
                   .map {|l| Program.new(l)}
                   .map {|p| [p.name, p]}
                   .to_h

    groups = Set.new
    all_progs = Set.new programs.keys

    # puts programs.keys
    # puts [Set.new([0]), Set.new([2]), Set.new([4])].flat_map {|p| p.to_a}
    # puts all_progs.difference(Set.new([Set.new([0]), Set.new([2]), Set.new([4])]).flat_map {|p| p}).first

    names_not_in_groups = all_progs.difference(groups.flat_map {|g| g.to_a})
    # puts "first not in group: #{names_not_in_groups.first}"
    while names_not_in_groups.any?
      # puts names_not_in_groups.first
      groups.add(build_group_from_progs names_not_in_groups.first, programs)
      # puts "first group: #{groups.first.to_a.join(',')}"
      names_not_in_groups = all_progs.difference(groups.flat_map {|g| g.to_a})
      # puts "first not in group: #{names_not_in_groups.first}"
    end
    groups.size
  end
end

