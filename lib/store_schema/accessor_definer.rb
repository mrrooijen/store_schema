class StoreSchema::AccessorDefiner

  # @return [Class]
  #
  attr_reader :klass

  # @return [Symbol]
  #
  attr_reader :column

  # @return [Symbol]
  #
  attr_reader :type

  # @return [Symbol]
  #
  attr_reader :attribute

  # @param klass [Class] the class to define the accessor on
  # @param column [Symbol] the name of the column to define the accessor on
  # @param type [Symbol] the data type of the {#attribute}
  # @param attribute [Symbol] the name of the {#column}'s attribute
  #
  def initialize(klass, column, type, attribute)
    @klass     = klass
    @column    = column
    @type      = type
    @attribute = attribute
  end

  # Defines all necessary accessors on {#klass}.
  #
  def define
    define_store_accessor
    define_attribute
    define_getter
    define_setter
  end

  private

  # Defines the standard store accessor.
  #
  def define_store_accessor
    klass.store_accessor(column, attribute)
  end

  # Defines the attribute on the class using the {.attribute}.
  #
  def define_attribute
    klass.attribute(attribute)
  end

  # Enhances the store getter by adding data conversion capabilities.
  #
  def define_getter
    _type = type

    klass.send(:define_method, attribute) do
      value = super()

      if value.is_a?(NilClass)
        value
      else
        StoreSchema::Converter.new(value, _type).from_db
      end
    end
  end

  # Enhances the store setter by adding data conversion capabilities.
  #
  def define_setter
    _type = type

    klass.send(:define_method, "#{attribute}=") do |value|
      converted_value = StoreSchema::Converter.new(value, _type).to_db

      if converted_value
        super(converted_value)
      else
        super(nil)
      end
    end
  end
end
