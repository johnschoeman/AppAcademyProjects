require 'hand'
require 'rspec'

describe Hand do
  let(:empty_hand) {Hand.new}

  let(:five_card_hand) {Hand.new}

  let(:four_card_hand) { Hand.new() }
  before(:each) do

    5.times do |i|
      five_card_hand.receive_card(Card.new(:c,i))
    end

    4.times do |i|
      four_card_hand.receive_card(Card.new(:c, i))
    end

  end

  let(:flush_hand) { Hand.new([Card.new(:c, 7),Card.new(:c, 7),Card.new(:c, 7),Card.new(:c, 7),Card.new(:c, 7)])}
  let(:straight_hand) { Hand.new([Card.new(:h, 1),Card.new(:h, 2),Card.new(:c, 3),Card.new(:c, 4),Card.new(:c, 5)])}
  let(:pair_hand) { Hand.new([Card.new(:c, 2),Card.new(:c, 2),Card.new(:d, 3),Card.new(:s, 4),Card.new(:h, 5)])}
  let(:high_card_hand) { Hand.new([Card.new(:c, 5),Card.new(:c, 2),Card.new(:d, 3),Card.new(:s, 4),Card.new(:h, 11)])}
  let(:higher_card_hand) { Hand.new([Card.new(:c, 5),Card.new(:c, 2),Card.new(:d, 3),Card.new(:s, 4),Card.new(:h, 12)])}


  describe "initialize" do
    it "initializes a hand" do
      expect(empty_hand).to be_instance_of(Hand)
    end

    it "initializes an empty array for cards" do
      expect(empty_hand.hand).to be_instance_of(Array)
      expect(empty_hand.hand).to be_empty
    end


  end

  describe "#receive_card" do
    context "hand less than five cards" do

      it "adds a card to a hands cards array" do
        empty_hand.receive_card(Card.new(:c,3))
        expect(empty_hand.hand.count).to be(1)
        expect(empty_hand.hand.first).to be_instance_of(Card)
      end
    end

    context "when hand has five cards" do

      it "raises error upon adding sixth card" do
        expect {five_card_hand.receive_card(Card.new(:c,1))}.to raise_error "Can't add to full hand"

      end
    end

  end


  describe "#rank" do

    it "returns nil for a hand without 5 cards" do
      expect {four_card_hand.rank}.to raise_error("Need 5 card hand to calculate rank")
    end

    it "returns 3 for a straight" do
      expect(straight_hand.rank).to eq(3)
    end

    it "returns 2 for a flush" do

      expect(flush_hand.rank).to eq(2)
    end

    it "returns 1 for a pair" do
      expect(pair_hand.rank).to eq(1)
    end

    it "returns 0 for a high card" do
      expect(high_card_hand.rank).to eq(0)
    end
  end

  describe "#<=>" do
    it "returns a straight over a flush" do
      expect(straight_hand.<=>(flush_hand)).to eq(straight_hand)
    end

    it "returns a flush over a pair" do
      expect(flush_hand.<=>(pair_hand)).to eq(flush_hand)
    end

    it "returns a pair over a high card" do
      expect(pair_hand.<=>(high_card_hand)).to eq(pair_hand)
    end

    it "returns hand with highest card" do
      expect(high_card_hand.<=>(higher_card_hand)).to eq(higher_card_hand)
    end

    it "returns a draw when hands are the same" do
      expect(pair_hand.<=>(pair_hand)).to eq("draw")
    end
  end
end
