class TreeNodes
  include Searchable

  attr_accessor :value, :parent

  def initialize(value = nil)
    @value, @parent, @children = value, nil, []
  end

  def children
    @children.dup
  end

  def add_child(new_child)
    @children << new_child
    new_child.parent = self
  end

  def remove_child(child)
    @children.delete(child)
    child.parent = nil
  end
end

module Searchable
  def dfs(target = nil, &prc)
    if prc.nil?
      return self if value == target
    else
      return self if prc.call(self)
    end

    children.each do |child|
      next if child.nil?

      result = child.dfs(target, &prc)
      return result unless result.nil?
    end

    nil
  end

  def bfs(target = nil, &prc)
    nodes = [self]
    until nodes.empty?
      node = nodes.shift

      if prc.nil?
        return node if node.value == target
      else
        return node if prc.call(node)
      end

      nodes.concat(node.children)
    end

    nil
  end
end


