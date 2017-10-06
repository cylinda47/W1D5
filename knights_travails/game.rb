require_relative '../skeleton/lib/00_tree_node.rb'
require 'byebug'

class KnightPathFinder

  $SIZE = 8
  attr_reader :visitied_positions

  def initialize(start_pos)
    @board = Array.new($SIZE) { Array.new($SIZE) }
    @start_pos = start_pos
    @visited_positions = Hash.new
    @move_tree = build_move_tree
  end

  def build_move_tree
    root = PolyTreeNode.new(@start_pos)
    queue = [root]
    until queue.empty?
      node = queue.shift
      @visited_positions[node.value] = true
      new_move_positions(node.value).each do |pos|
        child = PolyTreeNode.new(pos)
        child.parent = node
        queue.push(child)
      end
    end
    root
  end

  def new_move_positions(pos)
    KnightPathFinder.valid_moves(pos).reject { |move| @visited_positions.has_key?(move) }
  end

  def self.valid_moves(pos)
    valid_positions = []
    x, y = pos
    (-2..2).each do |i|
      (-2..2).each do |j|
        next if i.abs == j.abs
        next if i == 0 || j == 0
        new_pos = [x + i, y + j]
        valid_positions << new_pos if KnightPathFinder.valid_pos?(new_pos)
      end
    end
    valid_positions
  end

  def self.valid_pos?(pos)
    x, y = pos
    (0..$SIZE).cover?(x) && (0..$SIZE).cover?(y)
  end

  def find_path(end_pos)
    end_node = @move_tree.dfs(end_pos)
    track_path_back(end_node)
  end

  def track_path_back(end_node)
    path = [@start_pos]
    node = end_node
    until node.value == @start_pos
      path << node.value
      node = node.parent
    end
    path.sort
  end
end

def test_path(end_pos)
  kpf = KnightPathFinder.new([0, 0])
  path = kpf.find_path(end_pos)
  puts "path from #{end_pos} is: #{path}"
end

[[1,2], [5,7], [6,4], [8,8], [3,2]].each do |pos|
  test_path(pos)
end
