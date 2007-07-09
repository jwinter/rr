dir = File.dirname(__FILE__)
require "#{dir}/../../example_helper"

module RR
module Expectations
  describe ArgumentEqualityError, "#exact_match? with is_a argument" do
    before do
      @expectation = ArgumentEqualityError.new(numeric)
    end
    
    it "returns true when passed in an IsA module" do
      @expectation.should be_exact_match(WildcardMatchers::Numeric.new)
    end

    it "returns false otherwise" do
      @expectation.should_not be_exact_match("hello")
      @expectation.should_not be_exact_match(:hello)
      @expectation.should_not be_exact_match(1)
      @expectation.should_not be_exact_match(nil)
      @expectation.should_not be_exact_match()
    end
  end

  describe ArgumentEqualityError, "#wildcard_match? with is_a Numeric argument" do
    before do
      @expectation = ArgumentEqualityError.new(numeric)
    end

    it "returns true when passed a Numeric" do
      @expectation.should be_wildcard_match(99)
    end

    it "returns false when not passed a Numeric" do
      @expectation.should_not be_wildcard_match(:not_a_numeric)
    end

    it "returns true when an exact match" do
      @expectation.should be_wildcard_match(numeric)
    end

    it "returns false when not passed correct number of arguments" do
      @expectation.should_not be_wildcard_match()
      @expectation.should_not be_wildcard_match(1, 2)
    end
  end
end
end