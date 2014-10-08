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

    it "does not accept invalid data types" do
      expect { website.update_attribute(:name, true) }
        .to raise_error(
          StoreSchema::AccessorDefiner::InvalidValueType,
          "true (TrueClass) for Website#config.name (string)"
        )
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

    it "does not accept invalid string formats" do
      expect { website.update_attribute(:visitors, "abc") }
        .to raise_error(
          StoreSchema::AccessorDefiner::InvalidValueType,
          "abc (String) for Website#config.visitors (integer)"
        )
    end

    it "does not accept invalid data types" do
      expect { website.update_attribute(:visitors, true) }
        .to raise_error(
          StoreSchema::AccessorDefiner::InvalidValueType,
          "true (TrueClass) for Website#config.visitors (integer)"
        )
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

    it "does not accept invalid string formats" do
      expect { website.update_attribute(:apdex, "abc") }
        .to raise_error(
          StoreSchema::AccessorDefiner::InvalidValueType,
          "abc (String) for Website#config.apdex (float)"
        )
    end

    it "does not accept invalid data types" do
      expect { website.update_attribute(:apdex, true) }
        .to raise_error(
          StoreSchema::AccessorDefiner::InvalidValueType,
          "true (TrueClass) for Website#config.apdex (float)"
        )
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

    it "does not accept invalid data types" do
      expect { website.update_attribute(:ssl, "abc") }
        .to raise_error(
          StoreSchema::AccessorDefiner::InvalidValueType,
          "abc (String) for Website#config.ssl (boolean)"
        )
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

    it "does not accept invalid string formats" do
      expect { website.update_attribute(:published_at, "abc") }
        .to raise_error(
          StoreSchema::AccessorDefiner::InvalidValueType,
          "abc (String) for Website#config.published_at (datetime)"
        )
    end

    it "does not accept invalid data types" do
      expect { website.update_attribute(:published_at, true) }
        .to raise_error(
          StoreSchema::AccessorDefiner::InvalidValueType,
          "true (TrueClass) for Website#config.published_at (datetime)"
        )
    end
  end
end
