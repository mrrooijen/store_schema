# Store Schema

[![Gem Version](https://badge.fury.io/rb/store_schema.svg)](http://badge.fury.io/rb/store_schema)
[![Code Climate](https://codeclimate.com/github/meskyanichi/store_schema.png)](https://codeclimate.com/github/meskyanichi/store_schema)
[![Build Status](https://travis-ci.org/meskyanichi/store_schema.svg)](https://travis-ci.org/meskyanichi/store_schema)

StoreSchema, for Rails/ActiveRecord 4.0.0+, enhances `ActiveRecord::Base.store_accessor` with data conversion capabilities.

This library was developed for- and extracted from [HireFire].

The documentation can be found on [RubyDoc].


### Compatibility

- Rails/ActiveRecord 4.0.0+
- Ruby (MRI) 2.0+


### Installation

Add the gem to your Gemfile and run `bundle`.

```rb
gem "store_schema"
```


### Example

This example assumes you have a `websites` table with a column named
`config` of type `text`.

Define a model and use `store_schema`.

```rb
class Website < ActiveRecord::Base

  # Tell ActiveRecord that we want to serialize the :config attribute
  # and store the serialized data as text in the config column.
  #
  # By default, `store` serializes your data as YAML. You can swap this out for
  # any other coder you want. For example JSON or Oj (high performance JSON).
  #
  # If you're using PostgreSQL's hstore or json column-type instead of the
  # text column-type, you should'nt define `store :config`.
  #
  store :config, coder: JSON

  # Define a schema for the store. This syntax is similar to
  # ActiveRecord::Migration.
  #
  store_schema :config do |s|
    s.string :name
    s.integer :visitors
    s.float :apdex
    s.boolean :ssl
    s.datetime :published_at
  end
end
```

Now you can get and set attributes on the `websites.config` column using
the generated accessors.

```rb
website = Website.create(
  name: "Example Website",
  visitors: 1337,
  apdex: 1.0,
  ssl: true,
  published_at: Time.now
)

p website.name # => "Example Website" (String)
p website.visitors # => 1337 (Fixnum)
p website.apdex # => 1.0 (Float)
p website.ssl # => true (TrueClass)
p website.published_at # => "Thu, 18 Sep 2014 23:18:11 +0000" (DateTime)

p website.config
# =>
# {
#   "name" => "Example Website",
#   "visitors" => "1337",
#   "apdex" => "1.0",
#   "ssl" => "t",
#   "published_at" => "2014-09-18 23:18:11.583168000"
# }
```

That's it. This is similar to just using `store_accessor`, except that
`store_schema` is more strict as to what data types are stored. It attempts
to stay consistent with ActiveRecord's column conventions such as storing
booleans (`0`, `"0"`, `1`, `"1"`, `"t"`, `"T"`, `"f"`, `"F"`, `true`,
`"true"`, `"TRUE"`, `false`, `"false"`, `"FALSE"`, `"on"`, `"ON"`, `"off"`,
`"OFF"`) as `"t"` and `"f"`, storing `Time`, `Date` as `DateTime`,
ensuring `Time` is UTC prior to being stored, and more.

When accessing stored data, it properly converts them to their data types.
For example, `"t"` is converted to a TrueClass, and
`"2014-09-18 23:18:11.583168000"` is converted back to a DateTime.
See above example.

If you need to be able to query these serialized attributes,
consider using [PostgreSQL's HStore Extension]. If you do not need to
be able to query the serialized data, you can simply use a text-type column
and use the `store <column>[, coder: JSON]` method in your model which works
with any SQL database.


### Contributing

Contributions are welcome, but please conform to these requirements:

- Ruby (MRI) 2.0+
- ActiveRecord 4.0.0+
- 100% Spec Coverage
  - Generated by when running the test suite
- 100% [Passing Specs]
  - Run test suite with `$ rspec spec`
- 4.0 [Code Climate Score]
  - Run `$ rubycritic lib` to generate the score locally and receive tips
  - No code smells
  - No duplication

To start contributing, fork the project, clone it, and install the development dependencies:

```
git clone git@github.com:USERNAME/store_schema.git
cd store_schema
bundle
```

Ensure that everything works:

```
rspec spec
rubycritic lib
```

To run the local documentation server:

```
yard server --reload
```

Create a new branch and start hacking:

```
git checkout -b my-contributions
```

Submit a pull request.


### Author / License

Released under the [MIT License] by [Michael van Rooijen].

[Michael van Rooijen]: https://twitter.com/meskyanichi
[HireFire]: http://hirefire.io
[Passing Specs]: https://travis-ci.org/meskyanichi/store_schema
[Code Climate Score]: https://codeclimate.com/github/meskyanichi/store_schema
[RubyDoc]: http://rubydoc.info/github/meskyanichi/store_schema/master/frames
[MIT License]: https://github.com/meskyanichi/store_schema/blob/master/LICENSE
[RubyGems.org]: https://rubygems.org/gems/store_schema
[PostgreSQL's HStore Extension]: http://www.postgresql.org/docs/9.3/static/hstore.html
