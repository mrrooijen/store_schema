class StoreSchema::Configuration

  # @return [Symbol]
  #
  attr_reader :column

  # @return [Hash]
  #
  attr_reader :attributes

  # @param column [Symbol] the table column to generate the accessors for
  #
  def initialize(column)
    @column = column
    @attributes = {}
  end

  # @param attribute [Symbol] the name of the attribute on {#column}
  #   for which to generate a String-type accessor
  #
  def string(attribute)
    attributes[attribute] = :string
  end

  # @param attribute [Symbol] the name of the attribute on {#column}
  #   for which to generate an Integer-type accessor
  #
  def integer(attribute)
    attributes[attribute] = :integer
  end

  # @param attribute [Symbol] the name of the attribute on {#column}
  #   for which to generate a Float-type accessor
  #
  def float(attribute)
    attributes[attribute] = :float
  end

  # @param attribute [Symbol] the name of the attribute on {#column}
  #   for which to generate a DateTime-type accessor
  #
  def datetime(attribute)
    attributes[attribute] = :datetime
  end

  # @param attribute [Symbol] the name of the attribute on {#column}
  #   for which to generate a Boolean-type accessor
  #
  def boolean(attribute)
    attributes[attribute] = :boolean
  end

  private

  # Iterates over all defined {#attributes} and defines the
  # necessary accessors for them.
  #
  # @param klass [Class] the class to define the accessors on
  #
  def configure(klass)
    attributes.each do |attribute, type|
      StoreSchema::AccessorDefiner
        .new(klass, column, type, attribute).define
    end
  end
end
