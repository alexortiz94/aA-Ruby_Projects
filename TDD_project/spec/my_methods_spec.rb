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
end
