require_relative "base"

class StoreSchema::Converter::String < StoreSchema::Converter::Base

  # Simply returns {#value} if it's a String.
  #
  # @return [String, false] false if {#value} is an invalid date-type.
  #
  def to_db
    if value.is_a?(::String)
      value
    else
      false
    end
  end

  # Simply returns {#value} since it's already a String-type.
  #
  # @return [String]
  #
  def from_db
    value
  end
end
