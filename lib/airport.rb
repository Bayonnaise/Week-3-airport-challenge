require_relative 'weather_condition'

class Airport

	include WeatherCondition

	DEFAULT_CAPACITY = 6

	attr_reader :planes, :capacity

	def initialize(options = {})
		@capacity = options.fetch(:capacity, DEFAULT_CAPACITY)
		@planes = []
	end

	def empty?
		planes == []
	end

	def full?
		planes.count == capacity
	end

	def accept(plane)
		return if full? || !plane.flying? || weather == "stormy"
		plane.land!
		planes << plane
	end

	def release(plane)
		return if plane.flying? || weather == "stormy"
		plane.take_off!
		planes.delete(plane)
	end

end