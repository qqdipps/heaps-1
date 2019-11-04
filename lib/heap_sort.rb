

# This method uses a heap to sort an array.
# Time Complexity:  O(nlogn)
# Space Complexity: O(n)
def heapsort(list)
  heapify(list, parent(list.length - 1)) if list.length > 1
  sort_heaped_list(list)
  return list
end

private 
# Time Complexity:  O(nlog(n))
# Space Complexity: O(1) 
def sort_heaped_list(list)
  last_pos = list.length - 1
  while last_pos > 0
    remove_max(list, last_pos)
    last_pos -= 1
  end
end

# Time Complexity:  O(log(n))
# Space Complexity: O(1)
def remove_max(list, last_pos)
  removed = list[0]
  list[0] = list[last_pos] 
  list[last_pos] = removed
  heap_down(0, last_pos - 1, list)
end

# Time Complexity:  O(log(n))
# Space Complexity: O(1)
def heap_down(sub_root, last_pos, list)
  max_child = max_child(right_child(sub_root, last_pos), left_child(sub_root, last_pos), list)
  while max_child && max_child > sub_root
    swap(sub_root, max_child, list)
    sub_root = max_child
    max_child = max_child(right_child(sub_root, last_pos), left_child(sub_root, last_pos), list)
  end
end

# Time Complexity:  O(n)  => this is based of the math proof on geeks for geeks, not sure if I 100 % understand ... yet
# Space Complexity: O(n) <= can optimize by using iterative approach over recursion
def heapify(list, sub_root, counter = 0)
  max_child = max_child(right_child(sub_root, list.length), left_child(sub_root, list.length), list)
  if max_child && list[max_child] > list[sub_root]
    swap(max_child, sub_root, list)
    heapify(list, max_child, counter + 1)
  elsif max_child
    heapify(list, sub_root - 1, counter + 1)
  end 
  return 
end


# Time Complexity:  O(1)
# Space Complexity: O(1)
def swap(index1, index2, list)
  temp = list[index1]
  list[index1] = list[index2]
  list[index2] = temp
end

# Time Complexity:  O(1)
# Space Complexity: O(1)
def max_child(left, right, list)
  if !right || !left || list[left] > list[right]
    return left
  end
  return right
end

# Time Complexity:  O(1)
# Space Complexity: O(1)
def parent(child)
  return (child - 1) / 2
end

# Time Complexity:  O(1)
# Space Complexity: O(1)
def right_child(root, length)
  child = root * 2 + 2
  if child < length
    return child
  end
  return
end

# Time Complexity:  O(1)
# Space Complexity: O(1)
def left_child(root, length)
  child = root * 2 + 1
  if child < length
    return child
  end
  return
end