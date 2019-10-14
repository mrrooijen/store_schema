# frozen_string_literal: true

class StoreSchema::Converter
  require_relative "converter/string"
  require_relative "converter/integer"
  require_relative "converter/float"
  require_relative "converter/date_time"
  require_relative "converter/boolean"

  # @return [Hash] a mapping between the configuration block
  #   and the converter classes.
  #
  MAPPING = {
    :string   => String,
    :integer  => Integer,
    :float    => Float,
    :datetime => DateTime,
    :boolean  => Boolean,
  }

  # @return [Object]
  #
  attr_reader :value

  # @return [Symbol]
  #
  attr_reader :type

  # @param value [Object] any kind of value that should be stored
  # @param type [Symbol] the type of the value
  #
  def initialize(value, type)
    @value = value
    @type  = type
  end

  # Converts {#value} from a Ruby-type value to a database-storable value.
  #
  # @return [String]
  #
  def to_db
    MAPPING[type].new(value).to_db
  end

  # Converts {#value} from a database-storable value to a Ruby-type value.
  #
  # @return [Object]
  #
  def from_db
    MAPPING[type].new(value).from_db
  end
end
