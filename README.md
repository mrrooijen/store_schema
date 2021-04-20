# Store Schema

[![Gem Version](https://badge.fury.io/rb/store_schema.svg)](https://badge.fury.io/rb/store_schema)
[![Test Status](https://github.com/mrrooijen/store_schema/workflows/Test/badge.svg)](https://github.com/mrrooijen/store_schema/actions)

StoreSchema enhances `ActiveRecord::Base.store_accessor` with data type conversion capabilities.

This library was developed for- and extracted from [HireFire].

The documentation can be found on [RubyDoc].


### Compatibility

- Ruby 2.5+
- ActiveRecord 6.0+

It's likely that all ActiveRecord-supported databases will work.
However, we currently only test against PostgreSQL, MySQL and SQLite.


### Installation

Add the gem to your Gemfile and run `bundle`.

```rb
gem "store_schema"
```


### Example

This example assumes that you have a `websites` table with a `config` column of type `text`.

Define a model and use `store_schema`.

```rb
class Website < ActiveRecord::Base

  # Tell ActiveRecord that we want to serialize the :config attribute
  # and store the serialized data as text in the config column.
  #
  # By default, `store` serializes your data using the YAML coder. You can
  # swap the YAML coder out for other coders, such as JSON.
  #
  # Note: If you're using PostgresSQL hstore- or json instead of a
  # plain text column type, don't define `store :config`.
  #
  store :config, coder: JSON

  # Define a schema for the store. This syntax is similar to
  # ActiveRecord::Migration.
  #
  store_schema :config do |s|
    s.string   :name
    s.integer  :visitors
    s.float    :apdex
    s.boolean  :ssl
    s.datetime :published_at
  end
end
```

Now you can get and set attributes on the `websites.config` column using
the generated accessors.

```rb
website = Website.create(
  :name         => "Example Website",
  :visitors     => 9001,
  :apdex        => 1.0,
  :ssl          => true,
  :published_at => Time.now
)

website.name         # => (String)    "Example Website"
website.visitors     # => (Integer)   9001
website.apdex        # => (Float)     1.0
website.ssl          # => (TrueClass) true
website.published_at # => (DateTime)  "Thu, 18 Sep 2014 23:18:11 +0000"

website.config
# =>
# {
#   "name"         => "Example Website",
#   "visitors"     => "9001",
#   "apdex"        => "1.0",
#   "ssl"          => "t",
#   "published_at" => "2014-09-18 23:18:11.583168000"
# }
```

This is similar to using ActiveRecord's built-in `store_accessor`, except
that `store_schema` is more strict about which data types are stored. It attempts
to remain consistent with ActiveRecord's regular column storage conventions.

* String
    * Assigned as: `String`
    * Stored as: `String`
    * Retrieved as: `String`
* Integer
    * Assigned as: `Integer`
    * Stored as: `String`
    * Retrieved as: `Integer`
* Float
    * Assigned as: `Float`
    * Stored as: `String`
    * Retrieved as: `Float`
* Boolean (TrueClass)
    * Assigned as: `1`, `"1"`, `"t"`, `"T"`, `true`, `"true"`, `"TRUE"`, `"on"`, `"ON"`
    * Stored as: `"t"`
    * Retrieved as: `true`
* Boolean (FalseClass)
    * Assigned as: `0`, `"0"`, `"f"`, `"F"`, `false`, `"false"`, `"FALSE"`, `"off"`, `"OFF"`
    * Stored as: `"f"`
    * Retrieved as: `false`
* DateTime
    * Assigned as: `Date`, `Time`, `DateTime`
    * Stored as: `"2014-09-18 23:18:11.583168000"` (using UTC time zone)
    * Retrieved as: `DateTime`

If you need to be able to query these serialized attributes, consider using
the PostgreSQL hstore extension. Otherwise, you can simply use a text column type
and define `store <column>[, coder: JSON]` in your model and it should work with
any ActiveRecord-compatible database.


### Contributing

Contributions are welcome, but please conform to these requirements:

- Ruby (MRI) 2.5+
- ActiveRecord 6.0+
- 100% Test Coverage
    - Coverage results are generated after each test run at `coverage/index.html`
- 100% Passing Tests
    - Run test suite with `$ rake test`

To start contributing, fork the project, clone it, and install the development dependencies:

```
$ git clone git@github.com:USERNAME/store_schema.git
$ cd store_schema
$ bundle
```

Tests are run against the following databases, so be sure they're installed prior to running the tests:

* PostgreSQL
* MySQL
* SQLite

To run the tests:

```
$ rake test
```

To run the local documentation server:

```
$ rake doc
```

Create a new branch to start contributing:

```
$ git checkout -b my-contribution master
```

Submit a pull request.


### Author / License

Released under the [MIT License] by [Michael van Rooijen].

[Michael van Rooijen]: https://twitter.com/mrrooijen
[HireFire]: https://www.hirefire.io
[Passing Specs]: https://travis-ci.org/mrrooijen/store_schema
[RubyDoc]: https://rubydoc.info/github/mrrooijen/store_schema/master/frames
[MIT License]: https://github.com/mrrooijen/store_schema/blob/master/LICENSE
