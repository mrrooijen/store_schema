require "spec_helper"

RSpec.describe "StoreSchema" do

  let(:website) { Website.new }

  describe "nil" do

    it "should stay nil" do
      website.update_attribute(:name, nil)
      expect(website.reload.name).to be_nil
    end
  end

  describe "string" do

    it "should remain a string" do
      website.update_attribute(:name, "Store Schema")
      expect(website.reload.name).to eq("Store Schema")
    end

    it "should convert to nil if incompatible type" do
      website.update_attribute(:name, true)
      expect(website.name).to eq(nil)
    end
  end

  describe "integer" do

    it "should cast to string and back to integer" do
      website.update_attribute(:visitors, 1337)
      expect(website.config["visitors"]).to eq("1337")
      expect(website.visitors).to eq(1337)
    end

    it "should accept a string value of a digit" do
      website.update_attribute(:visitors, "1337")
      expect(website.config["visitors"]).to eq("1337")
      expect(website.visitors).to eq(1337)
    end

    it "should convert to nil if incompatible value" do
      website.update_attribute(:visitors, "abc")
      expect(website.visitors).to eq(nil)
    end

    it "should convert to nil if incompatible type" do
      website.update_attribute(:visitors, true)
      expect(website.visitors).to eq(nil)
    end
  end

  describe "float" do

    it "should cast to string and back to float" do
      website.update_attribute(:apdex, 0.9)
      expect(website.config["apdex"]).to eq("0.9")
      expect(website.apdex).to eq(0.9)
    end

    it "should accept a string value of a float" do
      website.update_attribute(:apdex, "0.9")
      expect(website.config["apdex"]).to eq("0.9")
      expect(website.apdex).to eq(0.9)
    end

    it "should accept an integer value" do
      website.update_attribute(:apdex, 1)
      expect(website.config["apdex"]).to eq("1.0")
      expect(website.apdex).to eq(1.0)
    end

    it "should accept a string value of an integer" do
      website.update_attribute(:apdex, "1")
      expect(website.config["apdex"]).to eq("1.0")
      expect(website.apdex).to eq(1.0)
    end

    it "should convert to nil if incompatible value" do
      website.update_attribute(:apdex, "abc")
      expect(website.apdex).to eq(nil)
    end

    it "should convert to nil if incompatible type" do
      website.update_attribute(:apdex, true)
      expect(website.apdex).to eq(nil)
    end
  end

  describe "boolean" do

    it "should cast to string and back to boolean" do
      StoreSchema::Converter::Boolean::TRUE_VALUES.each do |value|
        website.update_attribute(:ssl, value)
        expect(website.config["ssl"]).to eq("t")
        expect(website.ssl).to eq(true)
      end

      StoreSchema::Converter::Boolean::FALSE_VALUES.each do |value|
        website.update_attribute(:ssl, value)
        expect(website.config["ssl"]).to eq("f")
        expect(website.ssl).to eq(false)
      end
    end

    it "should convert to nil if incompatible type" do
      website.update_attribute(:ssl, "abc")
      expect(website.ssl).to eq(nil)
    end
  end

  describe "datetime" do

    it "should cast Date to string and back to datetime" do
      value = Date.new(2020)
      website.update_attribute(:published_at, value)
      expect(website.config["published_at"]).to eq("2020-01-01 00:00:00.000000000")
      expect(website.published_at).to eq("Wed, 01 Jan 2020 00:00:00.000000000 +0000")
      expect(website.published_at.class).to eq(DateTime)
    end

    it "should cast Time to string and back to datetime" do
      value = Time.utc(2020)
      website.update_attribute(:published_at, value)
      expect(website.config["published_at"]).to eq("2020-01-01 00:00:00.000000000")
      expect(website.published_at).to eq("Wed, 01 Jan 2020 00:00:00.000000000 +0000")
      expect(website.published_at.class).to eq(DateTime)
    end

    it "should cast DateTime to string and back to datetime" do
      value = DateTime.new(2020)
      website.update_attribute(:published_at, value)
      expect(website.config["published_at"]).to eq("2020-01-01 00:00:00.000000000")
      expect(website.published_at).to eq("Wed, 01 Jan 2020 00:00:00.000000000 +0000")
      expect(website.published_at.class).to eq(DateTime)
    end

    it "should convert to nil if incompatible value" do
      website.update_attribute(:published_at, "abc")
      expect(website.published_at).to eq(nil)
    end

    it "should convert to nil if incompatible type" do
      website.update_attribute(:published_at, true)
      expect(website.published_at).to eq(nil)
    end
  end
end
