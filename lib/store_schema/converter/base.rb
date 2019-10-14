# frozen_string_literal: true

class StoreSchema::Converter::Base

  # @return [Object]
  #
  attr_reader :value

  # @param [Object] value
  #
  def initialize(value)
    @value = value
  end
end
