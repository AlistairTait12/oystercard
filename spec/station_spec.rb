require 'station'

describe Station do 
  describe '#initialize' do
    station = Station.new('Victoria', 3)

    it 'new instances of Station class will need a name' do
      expect(station.name).to eq 'Victoria'
    end

    it 'new instances of Station will need a zone' do
      expect(station.zone).to eq 3
    end
  end

  describe 'Errors' do
    it 'prevents instantiation of Station objects if incorrect value types are passed as arguments' do
      expect{ station = Station.new(2, 'Victoria')}.to raise_error 'Station @name must be a string'
    end

    it 'prevents instantiation of Station objects if incorrect value types are passed as arguments' do
      expect{ station = Station.new('Victoria', [])}.to raise_error 'Station @zone must be an integer'
    end
  end
end