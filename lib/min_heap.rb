class HeapNode
  attr_reader :key, :value

  def initialize(key, value)
    @key = key
    @value = value
  end
end

class MinHeap

  def initialize
    @store = []
  end

  # This method adds a HeapNode instance to the heap
  # Time Complexity: O(log(n))
  # Space Complexity: 0(1)
  def add(key, value = key)
    @store << HeapNode.new(key, value)
    heap_up(@store.length - 1)
  end

  # This method removes and returns an element from the heap
  #   maintaining the heap structure
  # Time complexity: O(log(n))
  # Space complexity: O(1)
  def remove()
    removed = @store[0]
    @store[0] = @store.pop 
    heap_down(0)
    return removed.value
  end


  # Used for Testing
  def to_s
    return "[]" if @store.empty?

    output = "["
    (@store.length - 1).times do |index|
      output += @store[index].value + ", "
    end

    output += @store.last.value + "]"
      
    return output
  end

  # This method returns true if the heap is empty
  # Time complexity: O(1) assuming ruby implements array with memotized length ie attribute of array class rather than method
  # Space complexity: O(1)
  def empty?
    return @store.empty?
  end

  private

  # This helper method takes an index and
  #  moves it up the heap, if it is less than it's parent node.
  #  It could be **very** helpful for the add method.
  # Time complexity: O(log(n))
  # Space complexity: O(1)
  def heap_up(index)
    parent_i =  parent_index(index)
    until index == 0 || @store[parent_i].key < @store[index].key 
      swap(parent_i, index)
      index = parent_i
      parent_i = parent_index(index)
    end
  end

  def parent_index(index)
    return (index - 1) / 2
  end

  # This helper method takes an index and 
  #  moves it up the heap if it's smaller
  #  than it's parent node.
  # Time complexity: O(log(n))
  # Space complexity: O(1)
  def heap_down(index)
    right_child_i = right_child_index(index)
    left_child_i = left_child_index(index)
    until heaped_down_valid(left_child_i, right_child_i, index)
      pos_to_swap = index_of_smallest_child_key(left_child_i, right_child_i)
      swap(pos_to_swap, index)
      index = pos_to_swap
      right_child_i = right_child_index(index)
      left_child_i = left_child_index(index)
    end
  end

  def heaped_down_valid(left_child_i, right_child_i, index)
    return !left_child_i || @store[left_child_i].key > @store[index].key && (right_child_i && @store[right_child_i].key > @store[index].key)
  end

  def index_of_smallest_child_key(index1,  index2)
    if !index2 || @store[index2].key > @store[index1].key
      return index1
    else  
      return index2
    end
  end

  def right_child_index(index)
    if index * 2 + 2 <=  @store.length - 1
      return  index * 2 + 2
    end
    return
  end

  def left_child_index(index)
    if index * 2 + 1 <= @store.length - 1
      return  index * 2 + 1
    end
    return
  end

  # If you want a swap method... you're welcome
  def swap(index_1, index_2)
    temp = @store[index_1]
    @store[index_1] = @store[index_2]
    @store[index_2] = temp
  end
end