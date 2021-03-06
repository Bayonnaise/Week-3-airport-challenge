require 'plane'
require 'airport'

describe 'The final, ultimate, very last big test' do

	let (:airport) 	{ Airport.new }

	it 'all planes can land and take off' do
		planes = []
		(0..5).each { |i| planes[i] = Plane.new }

		until airport.full? do
			planes.each { |plane| airport.accept(plane) }
		end
	
		expect(airport).to be_full

		planes.each do |plane|
			expect(plane).not_to be_flying
		end
		
		until airport.empty? do
			planes.each { |plane| airport.release(plane) }
		end

		expect(airport).to be_empty

		planes.each do |plane|
			expect(plane).to be_flying
		end
		
	end
end