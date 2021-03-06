require 'byebug'
require_relative '02_searchable'
require 'active_support/inflector'

# Phase IIIa
class AssocOptions
  attr_accessor(
    :foreign_key,
    :class_name,
    :primary_key
  )

  def model_class
    self.class_name.constantize
  end

  def table_name
    self.model_class.table_name
  end
end

class BelongsToOptions < AssocOptions
  def initialize(name, options = {})
    @foreign_key = options[:foreign_key]
    @class_name = options[:class_name]
    @primary_key = options[:primary_key]

    @foreign_key ||= (name.to_s.underscore + "_id").to_sym
    @class_name ||= name.to_s.camelcase
    @primary_key ||= "id".to_sym
  end
end

class HasManyOptions < AssocOptions
  def initialize(name, self_class_name, options = {})
    @foreign_key = options[:foreign_key]
    @class_name = options[:class_name]
    @primary_key = options[:primary_key]

    @foreign_key ||= (self_class_name.to_s.underscore + "_id").to_sym
    @class_name ||= name.to_s.singularize.camelcase
    @primary_key ||= "id".to_sym
  end
end

module Associatable
  # Phase IIIb
  def belongs_to(name, options = {})
    options = BelongsToOptions.new(name, options)
    self.assoc_options[name] = options
    define_method(name) do
      target_class = options.model_class
      foreign_key_val = self.send(options.foreign_key)
      query = target_class.where(options.primary_key => foreign_key_val)
      query.first
    end
  end

  def has_many(name, options = {})
    options = HasManyOptions.new(name, self, options)
    define_method(name) do
      target_class = options.model_class
      foreign_key_val = self.send(options.primary_key)
      target_class.where(options.foreign_key => foreign_key_val)
    end

  end

  def assoc_options
    # Wait to implement this in Phase IVa. Modify `belongs_to`, too.
    @accoc_options ||= {}
  end
end

class SQLObject
  # Mixin Associatable here...
  extend Associatable
end
