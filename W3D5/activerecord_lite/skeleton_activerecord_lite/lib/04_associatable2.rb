require_relative '03_associatable'

# Phase IV
module Associatable
  # Remember to go back to 04_associatable to write ::assoc_options

  def has_one_through(name, through_name, source_name)
    # ...
    through_options = self.assoc_options[through_name]

    define_method(name) do
      source_options = through_options.model_class.assoc_options[source_name]
      source_class = source_options.model_class

      through_object = self.send(through_name)
      foreign_key_val = through_object.send(source_options.foreign_key)
      source_class.where(source_options.primary_key => foreign_key_val).first
    end
  end
end
