require_relative "base"

class StoreSchema::Converter::DateTime
  include StoreSchema::Converter::Base

  # @return [String] the database format for storing a DateTime object.
  #
  DATETIME_DB_FORMAT = "%Y-%m-%d %H:%M:%S.%N"

  # Converts the {#value} to a database-storable value.
  #
  # @return [String, false] false if {#value} is an invalid date-type.
  #
  def to_db
    begin
      case value
      when ::DateTime, ::Date
        value.strftime(DATETIME_DB_FORMAT)
      when ::Time
        value.utc.strftime(DATETIME_DB_FORMAT)
      when ::String
        ::DateTime.parse(value).strftime(DATETIME_DB_FORMAT)
      else
        false
      end
    rescue
      false
    end
  end

  # Converts the {#value} to a Ruby-type value.
  #
  # @return [DateTime]
  #
  def from_db
    ::DateTime.parse(value)
  end
end
