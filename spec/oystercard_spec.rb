require 'oystercard'

$limit = Oystercard::LIMIT
$minimum = Oystercard::MINIMUM
$example_station = 'example station'

describe Oystercard do
  
  before (:each) do
    subject.top_up($limit)
  end

  describe '@balance' do
    it 'tells the customer their balance' do
      expect(subject.balance).to eq $limit
    end
  end

  describe '#top_up' do
    it 'increases the balance of Oystercard' do
      expect(subject.balance).to eq $limit
    end

    it "throws an error if customer tries to increase credit above #{$limit}" do
      expect{ subject.top_up($minimum) }.to raise_error "Your credit cannot go over #{$limit}"
    end
  end

  describe '#deduct' do
    it 'deducts money from balance when customer travels' do
      subject.touch_out($example_station)
      expect(subject.balance).to eq $limit - $minimum
    end
  end

  describe '#touch_in' do
    it 'does not allow a customer to touch in when the balance is below the minimum' do
      subject = Oystercard.new # this overrides the before top up to set balance to 0, better way to do this?
      expect{subject.touch_in("Victoria")}.to raise_error 'Insufficient funds for journey'
    end

    it 'remembers the entry station at the start of a journey' do
      station = double
      allow(station).to receive(:name) { "Victoria" }
      subject.touch_in(station.name)
      expect(subject.entry_station).to eq station.name
    end
  end

  describe '#touch_out' do
    it 'deducts the minimum amount from the balance when touched out' do
      expect{subject.touch_out($example_station)}.to change{subject.balance}.by -$minimum
    end

    it 'forgets entry_station when journey ends' do
      subject.touch_in("Victoria")
      expect{ subject.touch_out($example_station) }.to change{subject.entry_station}.to nil
    end
  end

  describe '#in_journey?' do
    it 'expect a new cards initial state not to be in a journey' do
      expect(subject).not_to be_in_journey
    end

    # not sure if this is better nested or unnested?
    # the idea is to DRY out the touch ins from the
    # tests so maybe the nest hurts readability (Comment from Graeme)

    describe '#in_journey after a card is touched in' do      
      before(:each) do
        subject.touch_in("Victoria")
      end
          
      it 'returns whether a card is in use after #touch_in' do
        expect(subject).to be_in_journey
      end
  
     it 'still works after card #touch_in then #touch_out' do
        subject.touch_out($example_station)
        expect(subject).not_to be_in_journey
      end      
    end
  end

  describe "#journey_history" do
    it 'A new instance of Oystercard will have an empty journey_history' do
      expect(subject.journey_history).to eq []
    end

    it 'can hold journeys in the @journey_history instance var and return them' do
      subject.touch_in("London Bridge")
      subject.touch_out("Victoria")
      expect(subject.journey_history).to eq [{:in => 'London Bridge', :out => 'Victoria'}]
    end
  end
end