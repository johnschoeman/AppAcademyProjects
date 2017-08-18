class AttrAccessorObject
  def self.my_attr_accessor(*names)
    names.each do |name|
      define_method(name) do
        var = "@#{name.to_s}".to_sym
        instance_variable_get(var)
      end
      define_method("#{name.to_s}=".to_sym) do |val|
        var = "@#{name.to_s}".to_sym
        instance_variable_set(var, val)
      end
    end
  end
end
