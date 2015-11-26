require_relative "base"

class StoreSchema::Converter::Integer < StoreSchema::Converter::Base

  # @return [Regexp] the int value format.
  #
  INT_FORMAT = /^\d+$/

  # Converts the {#value} to a database-storable value.
  #
  # @return [String, false] false if {#value} is an invalid date-type.
  #
  def to_db
    case value
    when ::Integer
      value.to_s
    when ::String
      if value.match(INT_FORMAT)
        value
      else
        false
      end
    else
      false
    end
  end

  # Converts the {#value} to a Ruby-type value.
  #
  # @return [Integer]
  #
  def from_db
    value.to_i
  end
end
