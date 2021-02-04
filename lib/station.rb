class Station
  attr_reader :name, :zone
  def initialize(name, zone)
    fail 'Station @name must be a string' unless name.is_a?(String)
    fail 'Station @zone must be an integer' unless zone.is_a?(Integer)
    @name = name
    @zone = zone
  end
end