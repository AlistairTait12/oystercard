require 'oystercard'
require 'station'
require 'journey'

describe Journey do
  describe 'state' do
    before(:each) do
      oystercard = Oystercard.new
      oystercard.top_up(Oystercard::LIMIT)
    end

    xit 'can contain an @entry_station' do
      oystercard.touch_in('Victoria')
      expect(oystercard.journey_history).to eq []
    end

    xit 'can contain an @exit_station upon touch out' do
      oystercard.touch_out('Kings Cross')
      expect(oystercard.journey_history)
    end
  end
end