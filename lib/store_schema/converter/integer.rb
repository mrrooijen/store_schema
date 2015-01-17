require_relative "base"

class StoreSchema::Converter::Integer < StoreSchema::Converter::Base

  # Converts the {#value} to a database-storable value.
  #
  # @return [String, false] false if {#value} is an invalid date-type.
  #
  def to_db
    case value
    when ::Integer
      value.to_s
    when ::String
      if value =~ /^\d+$/
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
