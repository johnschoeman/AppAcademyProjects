class Array

  def my_each(&prc)
    count = 0
    while count < self.length
      prc.call(self[count])
      count += 1
    end
    self
  end

  def my_select(&prc)
    arr = []
    self.my_each do |el|
      arr.push(el) if prc.call(el)
    end
    arr
  end

  def my_reject(&prc)
    arr = []
    self.my_each do |el|
      arr.push(el) unless prc.call(el)
    end
    arr
  end

  def my_any?(&prc)
    self.my_each do |el|
      return true if prc.call(el)
    end
    false
  end

  def my_all?(&prc)
    self.my_each do |el|
      return false unless prc.call(el)
    end
    true
  end


  def my_flatten
    arr = []
    self.my_each do |el|
      if el.class == Array
        el.my_flatten.my_each do |sub_el|
          arr.push(sub_el)
        end
      else
        arr.push(el)
      end
    end
    arr
  end

  def my_zip(*arg)
    arr = []
    count = 0
    while count < self.length
      temp_arr = []
      temp_arr.push(self[count])
      arg.my_each do |el|
        temp_arr.push(el[count])
      end
      arr.push(temp_arr)
      count += 1
    end
    arr
  end

  def my_rotate(arg = 1)
    arr = self.dup
    (arg % self.length).times do
      count = 0
      while count < arr.length
        arr[count] = self[(count + arg) % arr.length]
        count += 1
      end
    end
    arr
  end

  def my_join(arg = "")
    result = ""
    (0...(self.length-1)).to_a.my_each do |i|
      result += self[i] + arg
    end
    result += self[-1]
    result
  end

  def my_reverse
    arr = []
    self.my_each do |el|
      arr.unshift(el)
    end
    arr
  end


  def my_inject(&prc)
    acc = self[0]
    (1...self.length).each do |i|
      acc = prc.call(acc, self[i])
    end
    acc
  end

end

# [1,2,3].inject { |acc, el| acc + el }
# [1,2,3].inject(:+)

def factors(num)

end

if __FILE__ == $PROGRAM_NAME
  p [1, 2, 3, [4, [5, 6]], [[[7]], 8]].my_flatten # => [1, 2, 3, 4, 5, 6, 7, 8]
#
#   a = [ 4, 5, 6 ]
# b = [ 7, 8, 9 ]
# p [1, 2, 3].my_zip(a, b) # => [[1, 4, 7], [2, 5, 8], [3, 6, 9]]
# p a.my_zip([1,2], [8])   # => [[4, 1, 8], [5, 2, nil], [6, nil, nil]]
# p [1, 2].my_zip(a, b)    # => [[1, 4, 7], [2, 5, 8]]
#
# c = [10, 11, 12]
# d = [13, 14, 15]
# p [1, 2].my_zip(a, b, c, d)    # => [[1, 4, 7, 10, 13], [2, 5, 8, 11, 14]]
#
# a = [ "a", "b", "c", "d" ]
# p a.my_rotate         #=> ["b", "c", "d", "a"]
# p a.my_rotate(2)      #=> ["c", "d", "a", "b"]
# p a.my_rotate(-3)     #=> ["b", "c", "d", "a"]
# p a.my_rotate(15)     #=> ["d", "a", "b", "c"]
#
# a = [ "a", "b", "c", "d" ]
# p a.my_join         # => "abcd"
# p a.my_join("$")    # => "a$b$c$d"
#
# p [ "a", "b", "c" ].my_reverse   #=> ["c", "b", "a"]
# p [ 1 ].my_reverse               #=> [1]
  p [1,-1,7].my_inject{|acc, el| acc - el }
end
