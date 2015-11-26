require_relative "base"

class StoreSchema::Converter::Float < StoreSchema::Converter::Base

  # @return [Regexp] an (int | float) value format.
  #
  INT_FLOAT_FORMAT = /^\d+|\d+\.\d+$/

  # Converts the {#value} to a database-storable value.
  #
  # @return [String, false] false if {#value} is an invalid date-type.
  #
  def to_db
    case value
    when ::Integer
      value.to_f.to_s
    when ::Float
      value.to_s
    when ::String
      if value.match(INT_FLOAT_FORMAT)
        value.to_f.to_s
      else
        false
      end
    else
      false
    end
  end

  # Converts the {#value} to a Ruby-type value.
  #
  # @return [Float]
  #
  def from_db
    value.to_f
  end
end
