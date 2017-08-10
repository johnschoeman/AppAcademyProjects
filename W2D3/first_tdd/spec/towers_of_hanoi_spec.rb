require 'towers_of_hanoi'
require 'rspec'

describe "TowersOfHanoi" do
  subject(:game) { TowersOfHanoi.new}

  describe "#initialize" do
    it "initializes" do
      expect(game).to be_instance_of(TowersOfHanoi)
    end

    it "initializes with discs array" do
      expect(game.discs).to eq([[1,2,3],[],[]])
    end
  end

  describe "#move_disc" do


    it "moves a disc" do
      game.move_disc(0,1)
      expect(game.discs).to eq([[2,3],[1],[]])
    end

    context "doesn't allow illegal moves" do
      before(:each) do
        game.move_disc(0,2)
        game.move_disc(0,1) # game.discs = [[3],[2],[1]]
      end

        it "doesn't allow a larger disc to be placed onto a smaller disc" do
          expect {game.move_disc(0,2)}.to raise_error("Can't move larger disc onto smaller disc")
        end

        it "doesn't allow indexes out of bounds" do
          expect {game.move_disc(0,5)}.to raise_error("Can't move disc off of towers")
        end

        it "selects a disc on the towers" do
          expect {game.move_disc(-1,2)}.to raise_error("Please pick disc on tower")
        end

    end
  end

  describe "#won?" do

    it "returns trure if game won" do
        game.move_disc(0,2)
        game.move_disc(0,1)
        game.move_disc(2,1)
        game.move_disc(0,2)
        game.move_disc(1,0)
        game.move_disc(1,2)
        game.move_disc(0,2)

        expect(game).to be_won
    end

    it "returns false if game not won" do
      expect(game.won?).to be false
    end
  end
end
