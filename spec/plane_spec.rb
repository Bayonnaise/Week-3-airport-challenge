require 'plane'

describe Plane do
	let(:plane_in_air)    { Plane.new }
	let(:plane_on_ground) { Plane.new.land! }

	it 'has a flying status when created' do
		expect(plane_in_air).to be_flying
	end

	it 'can land' do
		expect(plane_in_air.land!).not_to be_flying
	end

	it 'can take off' do
		expect(plane_on_ground.take_off!).to be_flying
	end

end