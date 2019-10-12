require "test_helper"

models = [WebsiteJSON, WebsiteYAML]

describe StoreSchema do

  models.each do |model|

    describe "nil" do

      it "stays nil" do
        website = model.create(name: nil)
        assert_nil website.reload.name
      end
    end

    describe "string" do

      it "remains a string" do
        website = model.create(name: "Store Schema")
        assert_equal "Store Schema", website.reload.name
      end

      it "converts to nil on incompatible type" do
        website = model.create(name: true)
        assert_nil website.name
      end
    end

    describe "integer" do

      it "casts to string and back to integer" do
        website = model.create(visitors: 1337)
        assert_equal "1337", website.config["visitors"]
        assert_equal 1337, website.visitors
      end

      it "accepts a string representation of an integer" do
        website = model.create(visitors: "1337")
        assert_equal "1337", website.config["visitors"]
        assert_equal 1337, website.visitors
      end

      it "converts to nil on invalid string" do
        website = model.create(visitors: "abc")
        assert_nil website.visitors
      end

      it "converts to nil on incompatible type" do
        website = model.create(visitors: true)
        assert_nil website.visitors
      end
    end

    describe "float" do

      it "casts to string and back to float" do
        website = model.create(apdex: 0.9)
        assert_equal "0.9", website.config["apdex"]
        assert_equal 0.9, website.apdex
      end

      it "accepts a string representation of a float" do
        website = model.create(apdex: "0.9")
        assert_equal "0.9", website.config["apdex"]
        assert_equal 0.9, website.apdex
      end

      it "accepts an integer" do
        website = model.create(apdex: 1)
        assert_equal "1.0", website.config["apdex"]
        assert_equal 1.0, website.apdex
      end

      it "accepts a string representation of an integer" do
        website = model.create(apdex: "1")
        assert_equal "1.0", website.config["apdex"]
        assert_equal 1.0, website.apdex
      end

      it "converts to nil on invalid string" do
        website = model.create(apdex: "abc")
        assert_nil website.apdex
      end

      it "converts to nil on incompatible type" do
        website = model.create(apdex: true)
        assert_nil website.apdex
      end
    end

    describe "boolean" do

      it "casts to string and back to boolean" do
        website = model.create

        StoreSchema::Converter::Boolean::TRUE_VALUES.each do |value|
          website.update_attribute(:ssl, value)
          assert_equal "t", website.config["ssl"]
          assert website.ssl
        end

        StoreSchema::Converter::Boolean::FALSE_VALUES.each do |value|
          website.update_attribute(:ssl, value)
          assert_equal "f", website.config["ssl"]
          refute website.ssl
        end
      end

      it "converts to nil on incompatible type" do
        website = model.create(ssl: "abc")
        assert_nil website.ssl
      end
    end

    describe "datetime" do

      it "casts date to string and back to datetime" do
        date    = Date.new(2020)
        website = model.create(published_at: date)
        assert_equal "2020-01-01 00:00:00.000000000", website.config["published_at"].to_s
        assert_equal date, website.published_at
        assert_instance_of DateTime, website.published_at
      end

      it "casts time to string and back to datetime" do
        time    = Time.utc(2020)
        website = model.create(published_at: time)
        assert_equal "2020-01-01 00:00:00.000000000", website.config["published_at"]
        assert_equal time, website.published_at
        assert_instance_of DateTime, website.published_at
      end

      it "casts datetime to string and back to datetime" do
        date_time = DateTime.new(2020)
        website   = model.create(published_at: date_time)
        assert_equal "2020-01-01 00:00:00.000000000", website.config["published_at"]
        assert_equal date_time, website.published_at
        assert_instance_of DateTime, website.published_at
      end

      it "converts to nil on incompatible value" do
        website = model.create(published_at: "abc")
        assert_nil website.published_at
      end

      it "converts to nil on incompatible type" do
        website = model.create(published_at: true)
        assert_nil website.published_at
      end
    end
  end
end
