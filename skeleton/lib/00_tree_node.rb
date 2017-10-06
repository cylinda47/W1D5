class PolyTreeNode

  def initialize(value)
    @parent = nil
    @children = []
    @value = value
  end

  def parent
    @parent
  end

  def children
    @children
  end

  def value
    @value
  end

  def parent=(node)
    @parent.children.delete(self) if @parent
    @parent = node
    if @parent && !@parent.children.include?(self)
      @parent.children << self
    end
  end

  def add_child(child_node)
    #@children << child_node
    child_node.parent = self
  end

  def remove_child(child_node)
    raise "Error: Node is not a child." unless @children.include?(child_node)
    @children.delete(child_node)
    child_node.parent = nil
  end

  def dfs(target_value)
    return self if self.value == target_value
    self.children.each do |child_node|
      result = child_node.dfs(target_value)
      return result if result
    end
    nil
  end

  def bfs(target_value)
    queue = [self]
    until queue.empty?
      puts queue
      node = queue.shift
      return node if node.value == target_value
      queue.concat(node.children)
    end
    nil
  end
end
