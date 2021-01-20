require "rspec"
require "hanoi"

describe TowersOfHanoi do
    let(:my_game) { TowersOfHanoi.new }

    describe "#move" do 
        before(:each) { my_game.move(my_game.stacks[0],my_game.stacks[2]) }
        context "when an invalid move is made" do
            it "should raise an error when the player is trying to move from an empty stack" do
                expect{ my_game.move(my_game.stacks[1], my_game.stacks[2]) }.to raise_error("that stack is empty")
            end

            it "should raise an error when the player is trying to move a bigger piece onto a smaller one" do
                expect{ my_game.move(my_game.stacks[0], my_game.stacks[2]) }.to raise_error("you cannot move a larger disk on top of a smaller one")
            end
        end
        context "when a valid move is made" do
            it "should the remove the top disk from the stack the player chose to move from" do
                expect(my_game.stacks[0]).to match_array([3, 2])
            end
            it "should place the disk at the bottom of the stack the player chose to move to" do
                expect(my_game.stacks[2].first).to eq(1)
            end
        end
    end

    describe "#won?" do
        context "when the game hasn't been won" do
            it "should return false" do
                expect(my_game.won?).to eq(false)
            end
        end

        
        context "when the game has been won" do
            before(:each) do 
            my_game.move(my_game.stacks[0],my_game.stacks[2])
            my_game.move(my_game.stacks[0],my_game.stacks[1])
            my_game.move(my_game.stacks[2],my_game.stacks[1])
            my_game.move(my_game.stacks[0],my_game.stacks[2])
            my_game.move(my_game.stacks[1],my_game.stacks[0])
            my_game.move(my_game.stacks[1],my_game.stacks[2])
            my_game.move(my_game.stacks[0],my_game.stacks[2])
            end
            it "should return true" do
                expect(my_game.won?).to eq(true)
            end
        end
    end

end
