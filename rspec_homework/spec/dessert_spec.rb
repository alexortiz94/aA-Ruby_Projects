require 'rspec'
require 'dessert'

=begin
Instructions: implement all of the pending specs (the `it` statements without blocks)! Be sure to look over the solutions when you're done.
=end

describe Dessert do
  let(:chef) { double("chef") }
  subject(:dessert) { Dessert.new("maccaroon", 20, chef)}

  describe "#initialize" do
    it "sets a type" do
      expect(dessert.type).to eq("maccaroon")
    end 

    it "sets a quantity" do
      expect(dessert.quantity).to be_a(Integer)
    end

    it "starts ingredients as an empty array" do 
      expect(dessert.ingredients).to be_empty
    end 

    it "raises an argument error when given a non-integer quantity" do
      expect { Dessert.new("brownie", "a bunch", chef) }.to raise_error(ArgumentError)
    end

  end

  describe "#add_ingredient" do
    it "adds an ingredient to the ingredients array" do
      dessert.add_ingredient("sugar")
      expect(dessert.ingredients).to_not be_empty
    end
  end

  describe "#mix!" do
    it "shuffles the ingredient array" do
      expect(dessert.ingredients).to receive(:shuffle!)
      dessert.mix!
    end
  end

  describe "#eat" do
    it "subtracts an amount from the quantity" do
      dessert.eat(5)
      expect(dessert.quantity).to eq(15)
    end

    it "raises an error if the amount is greater than the quantity" do
      expect { dessert.eat(25) }.to raise_error("not enough left!")
    end
  end

  describe "#serve" do
    it "contains the titleized version of the chef's name" do
      allow(chef).to receive(:titleize).and_return("Chef")
      expect(dessert.serve).to include("Chef")
    end
  end

  describe "#make_more" do
    it "calls bake on the dessert's chef with the dessert passed in" do
      expect(chef).to receive(:bake)
      dessert.make_more
    end
  end
end
