require 'airport'

describe Airport do
	let(:airport)         { Airport.new	 									}
	let(:plane_in_air)    { double :plane, flying?: true, land!: true		}
	let(:plane_on_ground) { double :plane, flying?: false, take_off!: true	}

	def fill_airport
		airport.capacity.times { airport.accept(plane_in_air) }
	end

	context 'creating' do
		it 'is empty when created' do
			expect(airport).to be_empty
		end

		it 'has a default capacity' do
			expect(airport.capacity).to eq 6
		end

		it 'can have a different capacity' do
			airport_3 = Airport.new(:capacity => 3)
			expect(airport_3.capacity).to eq 3
		end
	end

	context 'taking off and landing' do
		it 'can accept a plane' do
			airport.accept(plane_in_air)
			expect(airport.planes).to eq [plane_in_air]
		end

		it 'can not accept a plane already on the ground' do
			airport.accept(plane_on_ground)
			expect(airport).to be_empty
		end

		it 'changes status of plane when landed' do
			expect(plane_in_air).to receive(:land!)
			airport.accept(plane_in_air)
		end

		it 'can release a plane' do
			airport.planes << plane_on_ground
			airport.release(plane_on_ground)
			expect(airport.planes).to eq []
		end

		it 'can not release a plane already in the air' do
			airport.planes << plane_in_air
			airport.release(plane_in_air)
			expect(airport.planes).to eq [plane_in_air]
		end

		it 'changes status of plane when taking off' do
			expect(plane_on_ground).to receive(:take_off!)
			airport.release(plane_on_ground)
		end
	end

	context 'traffic control' do
		it 'knows when it is full' do
			expect(airport).not_to be_full
			fill_airport
			expect(airport).to be_full
		end

		it 'only accepts a plane if not full' do
			fill_airport
			airport.accept(plane_in_air)
			expect(airport).to be_full
		end

	end
end