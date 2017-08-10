require 'card'
require 'rspec'

describe Card do
  let(:card) { Card.new(:c, 2) }


  describe "#initialize" do

    it "initializes a card with suit and value" do
      expect(card).to be_instance_of(Card)
      expect(card.suit).to eq(:c)
      expect(card.value).to eq(2)


    end

    it "doesn't allow invalid suits" do
      expect {Card.new(:x,4)}.to raise_error "Invalid suit"
    end

    it "doesn't allow invalid values" do
      expect {Card.new(:c,35)}.to raise_error "Value out of range"
    end

  end

  describe "::standard_cards" do
    subject(:standard_cards) { Card.standard_cards }

    it "returns an array of 52 cards" do
      expect(standard_cards).to be_instance_of(Array)
      expect(standard_cards.length).to eq(52)

    end

    it "returns 13 of every suit" do
      expect(standard_cards.select { |card| card.suit == :c }.count ).to eq(13)
      expect(standard_cards.select { |card| card.suit == :h }.count ).to eq(13)
      expect(standard_cards.select { |card| card.suit == :s }.count ).to eq(13)
      expect(standard_cards.select { |card| card.suit == :d }.count ).to eq(13)
    end

    it "has 4 of every value" do
      (0..12).each do |val|
        expect(standard_cards.select { |card| card.value == val }.count ).to eq(4)
      end
    end

    it "only includes cards" do
      expect(standard_cards.all? { |item| item.is_a?(Card) }).to be true
    end
  end
end
