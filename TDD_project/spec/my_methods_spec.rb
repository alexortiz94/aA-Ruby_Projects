require "rspec"
require "my_methods"

describe Array do
    let(:my_array) { Array.new }

    describe "#my_uniq" do
        it "takes in an array as an argument" do
            expect{ my_array.my_uniq }.to_not raise_error
        end

        it "removes all doubles from the array and returns a new array" do
            my_array = [1, 2, 1, 3, 3]
            expect(my_array.my_uniq).to eq([1,2,3])
        end

    end

    describe "#two_sum" do
        it "finds all pairs of positions that sum to zero" do
            my_array = [-1, 0, 2, -2, 1]
            expect(my_array.two_sum).to match_array([[0,4], [2,3]])
        end
    end

    describe "#my_transpose" do
        it "takes a two-dimensional grid, and transposes the rows with the columns" do
            my_array = [
                [0,1,2],
                [3,4,5],
                [6,7,8]
            ]
            expect(my_array.my_transpose).to match_array([[0,3,6],[1,4,7],[2,5,8]])
        end
    end

    describe "#stock_picker" do
        my_array = [67, 68, 66, 72, 75, 85, 91, 88, 87] 
        it "takes in an array of stock prices on different days" do
            expect{ my_array.stock_picker }.to_not raise_error("all elements must be numbers")
        end

        it "returns the most profitable pair of days to buy, and then sell the stock" do
            expect(my_array.stock_picker).to match_array([2, 6])
        end

    end
        

end
