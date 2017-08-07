def factors(num)
  arr = []
  (1...num).each do |n|
    if num % n == 0
      arr.push(n)
    end
  end
  arr
end

class Array
  # def bubble_sort!
  #   self.length.times do
  #     (0...self.length - 1).each do |i|
  #       if self[i] > self[i + 1]
  #         self[i], self[i + 1] = self[i + 1], self[i]
  #       end
  #     end
  #   end
  #   self
  # end

  # def bubble_sort
  #   arr = self.dup
  #   arr.bubble_sort!
  # end

  def bubble_sort!(&prc)
      self.length.times do
        (0...self.length - 1).each do |i|
          if block_given?
            if prc.call(self[i],self[i + 1])
              self[i], self[i + 1] = self[i + 1], self[i]
            end
          else
            if self[i] > self[i + 1]
              self[i], self[i + 1] = self[i + 1], self[i]
            end
          end
        end
      end
      self
    end
end

def substrings(string)
  result = []
  (1..(string.length)).each do |i|
    # (i...string.length).each do |j|
    #   result.push(string[i..j])
    # end
    string.chars.each_cons(i){ |a| result.push(a.join) }
  end
  dictionary = string.chars
  result.flatten.uniq.sort_by{|x| dictionary}
end

def subwords(word, dictionary)
  substring_arr = substrings(word)
  substring_arr.select{|el| dictionary.include?(el)}
end

def doubler(arr)
  arr.map{|x| x * 2}
end

def concatenate(strings)
  strings.inject{|acc, word| acc + word}
end


if __FILE__ == $PROGRAM_NAME
  p factors(10)
  p factors(20)
  p factors(-5)
  p factors(0)

  p a = [3,2,1]
  p a.bubble_sort!
  p a
  p [5, 1, 2, 4, 3].bubble_sort!
  p [1, 3, 5].bubble_sort! { |num1, num2| num1 <=> num2 } #sort ascending
  p [1, 3, 5].bubble_sort! { |num1, num2| num2 <=> num1 } #sort descending

  p substrings("cat") # == ["c", "ca", "cat", "a", "at", "t"]
  p subwords("cat",["cat", "at", "a"])
  p doubler([1,2,3])
  p concatenate(["Yay ", "for ", "strings!"])
end
