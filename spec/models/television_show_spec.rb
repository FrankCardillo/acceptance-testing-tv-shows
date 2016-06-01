require "spec_helper"

describe TelevisionShow do
  let(:my_television_show) {TelevisionShow.new("title", "network", "2016", "mystery", "synopsis")}
  let(:bad_args) {TelevisionShow.new("", "", "2016", "not included genre", "test")}

  describe "#initialize" do
    it "has a title attribute" do
      expect(my_television_show.title).to eq("title")
    end

    it "has a network attribute" do
      expect(my_television_show.network).to eq("network")
    end

    it "has a starting year attribute" do
      expect(my_television_show.starting_year).to eq("2016")
    end

    it "has a genre attribute" do
      expect(my_television_show.genre).to eq("mystery")
    end

    it "has a synopsis attribute" do
      expect(my_television_show.synopsis).to eq("synopsis")
    end

    it "has an errors attribute" do
      expect(my_television_show.errors).to eq([])
    end
  end

  describe "#all" do
    it "returns an array of television show objects created from the csv" do
      CSV.open("../model-test.csv", "w")  do |line|
        puts ''
      end
      my_television_show.save('../model-test.csv')
      expect(TelevisionShow.all('../model-test.csv')[0].title).to eq(my_television_show.title)
    end
  end

  describe "#valid?" do
    it "returns true if none of the arguments supplied to the object are empty strings" do
      CSV.open("../model-test.csv", "w")  do |line|
        puts ''
      end
      expect(my_television_show.valid?("../model-test.csv")).to eq(true)
    end

    it "returns true if the object's title is not already present in the csv file" do
      CSV.open("../model-test.csv", "w")  do |line|
        puts ''
      end
      expect(my_television_show.valid?("../model-test.csv")).to eq(true)
    end

    it "returns false if either of these is untrue" do
      expect(bad_args.valid?("../model-test.csv")).to eq(false)
      my_television_show.save('../model-test.csv')
      expect(my_television_show.valid?("../model-test.csv")).to eq(false)
    end
  end

  describe "#save" do
    it "returns true and saves to the csv file if the object is valid" do
      CSV.open("../model-test.csv", "w")  do |line|
        puts ''
      end
      expect(my_television_show.save("../model-test.csv")).to eq(true)
      title = ""
      CSV.foreach("../model-test.csv", "r") do |line|
        title += line[0]
        break
      end
      expect(title).to eq(my_television_show.title)
    end

    it "returns false and does not save to the csv file if the object is not valid" do
      expect(bad_args.save('../model-test.csv')).to eq(false)
    end
  end

  describe "#errors" do
    it "returns an empty array when called on a newly initialized object" do
      expect(my_television_show.errors).to eq([])
    end

    it "includes the string 'Please fill in all required fields'
  when valid? is called on an object with empty strings as attrs" do
      bad_args.valid?("../model-test.csv")
      expect(bad_args.errors).to eq(['Please fill in all required fields'])
    end

    it "includes the string 'The show has already been added'
  when valid? is called on an object whose title is already in the csv file" do
    CSV.open("../model-test.csv", "w")  do |line|
      puts ''
    end
    original = TelevisionShow.new("Title", "network", "2016", "not included genre", "test")
    original.save('../model-test.csv')
    duplicate = TelevisionShow.new("Title", "network", "2016", "not included genre", "test")
    duplicate.valid?("../model-test.csv")
    expect(duplicate.errors).to eq(['The show has already been added'])
    end
  end
end
