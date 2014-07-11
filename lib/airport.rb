class Airport

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
		if plane.flying? && !full?
			plane.land!
			planes << plane
		end
	end

	def release(plane)
		if !plane.flying?
			plane.take_off!
			planes.delete(plane)
		end
	end
end