require "spec_helper"

describe TelevisionShow do
  let(:friends) { TelevisionShow.new("Friends","NBC","1994","Six friends living in New York city","Comedy") }
  describe "#initialize" do
    it "takes 5 arguments" do
      expect(friends).to be_a(TelevisionShow)
    end

    it "has readers for each class variable" do
      expect(friends.title).to eq("Friends")
      expect(friends.genre).to eq("Comedy")
    end

  end

  describe "#valid?" do
    it "returns true if @error is empty" do
      expect(friends.valid?).to eq(true)
    end

    invalid_show = TelevisionShow.new("Friends","NBC","","Six friends living in New York city","Comedy")

    it "returns true if @error is empty" do
      expect(invalid_show.valid?).to eq(false)
    end
  end
end
