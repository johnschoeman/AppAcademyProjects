class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    res = 0
    self.each_with_index do |el, i|
      res += (i+1)*(el.hash)
    end
    res
  end
end

class String
  def hash
    chars = self.chars
    chars.map! do |ch|
      ch.ord.hash
    end
    res = 0
    chars.each_with_index do |el, i|
      res += (i+1)*(el.hash)
    end
    res
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    hash_as_array = self.to_a.sort.flatten
    hash_as_array.map! do |el|
      if el.is_a?(Integer)
        el
      else
        el.to_s.ord
      end
    end
    hash_as_array.hash
  end
end
