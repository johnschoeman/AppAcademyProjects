require 'deck'
require 'rspec'
require 'byebug'

describe Deck do
  let (:deck) { Deck.new }

  describe "#intialize" do
    it "initializes" do
      expect(deck).to be_instance_of(Deck)
    end

  end

  describe "#shuffle!" do
    let (:cards) {deck.deck}

    it "shuffles the deck" do
      # expect(deck).to receive(:shuffle!)
      expect(cards).to receive(:shuffle!)
      deck.shuffle!
    end
  end

  describe "#take_top_card" do
    let (:cards) {deck.deck}

    it "removes top card" do
      deck.take_top_card
      expect(cards.count).to be(51)
    end

  end

end
