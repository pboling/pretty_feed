# PrettyFeed

PrettyFeed is a modulizer you can include in a job, worker, class, rake task, etc, which allows for simple pass/fail logging colorization.  Defaults are `truthy: 'green'` and `falsey: 'red'`.

While this gem has few direct dependencies, it won't accomplish do much for you unless you are using a "console output coloring" gem of some kind.

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add pretty_feed

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install pretty_feed

## Usage

```ruby
namespace :scrub do
  task blurb: :environment do |_t, _args|
    include PrettyFeed::PfTf.new(truthy: "green", falsey: "blue")
    pftf("this will be green: ", true)
    # => "this will be green: true" # in the console
    pftf("this will be blue: ", false)
    # => "this will be blue: false" # in the console
  end
end
```

Instead of passing truthy or falsey values, you can pass a proc that will be evaluated with the value passed to it as an argument.

```ruby
namespace :scrub do
  task blurb: :environment do |_t, someth|
    include PrettyFeed::PfTf.new(truthy: "green", falsey: "blue")
    pftf("might be green or blue: ", someth, ->(a) { a })
    # => "might be green or blue: #{someth}" # in the console
    #     NOTE: the color will depend on what someth is and whether the proc evaluates as truthy or falsey.
  end
end
```

### Options

Released v1.0.0 has new features, all tested at 100% line & branch coverage.
Overall I'm sure the library maintains >= 90% line & branch coverage, and probably 100%,
but combining the various runs with each String color library is hard.

- `pftf` now accepts a block, and when given:
    - `[BEG] #{msg}#{value}` is logged before executing the block
    - `[FIN] #{msg}#{value}` is logged after executing the block
- options hash as fourth parameter to `pftf`!
    - `:rescue_logged` - Error classes that should be rescued and logged. Default: `[]`
    - `:backtrace_logged` - When truthy, rescued errors log a full backtrace. Default: `nil`
    - `:reraise` - When truthy, rescued errors will be re-raised. Default: `nil`
    - `:benchmark` - When truthy, prints realtime spent executing block. Default: `nil`

Find examples of these options in use, with and without blocks,
in [`pf_tf_spec.rb`](/spec/pretty_feed/pf_tf_spec.rb), as all options are fully tested.

### Library Defaults

`ColorizedString` (from the [`colorize` gem](https://github.com/fazibear/colorize)) will be used if it is `defined?`.  I prefer it because it doesn't pollute the `String` class with color methods.

### Library Options

It will also work with strings that respond to the colors you select as methods on the `String` instance.  This means it should work with `colored2`, `awesome_print`, `term-ansicolor`, and many other similar gems.  If your strings do not respond to color methods there will be a `warn` message printed to STDERR.  Colors available depend on the gem you use to provide the color methods!  The various gems do not have uniform sets of colors, nor names of colors.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

See [CONTRIBUTING.md][contributing]

## Contributors

[![Contributors](https://contrib.rocks/image?repo=pboling/pretty_feed)]("https://github.com/pboling/pretty_feed/graphs/contributors")

Made with [contributors-img](https://contrib.rocks).

## License

The gem is available as open source under the terms of
the [MIT License][license] [![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)][license-ref].
See [LICENSE][license] for the official [Copyright Notice][copyright-notice-explainer].

* Copyright (c) 2022-2023 [Peter H. Boling][peterboling] of [Rails Bling][railsbling]

[copyright-notice-explainer]: https://opensource.stackexchange.com/questions/5778/why-do-licenses-such-as-the-mit-license-specify-a-single-year

## Code of Conduct

Everyone interacting in the PrettyFeed project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/pboling/pretty_feed/blob/main/CODE_OF_CONDUCT.md).

## Versioning

This library aims to adhere to [Semantic Versioning 2.0.0][semver]. Violations of this scheme should be reported as
bugs. Specifically, if a minor or patch version is released that breaks backward compatibility, a new version should be
immediately released that restores compatibility. Breaking changes to the public API will only be introduced with new
major versions.

As a result of this policy, you can (and should) specify a dependency on this gem using
the [Pessimistic Version Constraint][pvc] with two digits of precision.

For example:

```ruby
spec.add_dependency("pretty_feed", "~> 1.0")
```

[copyright-notice-explainer]: https://opensource.stackexchange.com/questions/5778/why-do-licenses-such-as-the-mit-license-specify-a-single-year

[gh_discussions]: https://github.com/pboling/pretty_feed/discussions

[conduct]: https://github.com/pboling/pretty_feed/blob/main/CODE_OF_CONDUCT.md

[contributing]: https://github.com/pboling/pretty_feed/blob/main/CONTRIBUTING.md

[security]: https://github.com/pboling/pretty_feed/blob/main/SECURITY.md

[license]: https://github.com/pboling/pretty_feed/blob/main/LICENSE.txt

[license-ref]: https://opensource.org/licenses/MIT

[semver]: http://semver.org/

[pvc]: http://guides.rubygems.org/patterns/#pessimistic-version-constraint

[railsbling]: http://www.railsbling.com

[peterboling]: http://www.peterboling.com

[aboutme]: https://about.me/peter.boling

[angelme]: https://angel.co/peter-boling

[coderme]:http://coderwall.com/pboling

[followme-img]: https://img.shields.io/twitter/follow/galtzo.svg?style=social&label=Follow

[tweetme]: http://twitter.com/galtzo

[politicme]: https://nationalprogressiveparty.org

[documentation]: https://rubydoc.info/github/pboling/pretty_feed/main

[source]: https://github.com/pboling/pretty_feed/

[actions]: https://github.com/pboling/pretty_feed/actions

[issues]: https://github.com/pboling/pretty_feed/issues

[climate_maintainability]: https://codeclimate.com/github/pboling/pretty_feed/maintainability

[climate_coverage]: https://codeclimate.com/github/pboling/pretty_feed/test_coverage

[codecov_coverage]: https://codecov.io/gh/pboling/pretty_feed

[code_triage]: https://www.codetriage.com/pboling/pretty_feed

[blogpage]: http://www.railsbling.com/tags/pretty_feed/

[rubygems]: https://rubygems.org/gems/pretty_feed

[chat]: https://gitter.im/pboling/pretty_feed?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge

[maintenancee_policy]: https://guides.rubyonrails.org/maintenance_policy.html#security-issues

[liberapay_donate]: https://liberapay.com/pboling/donate

[gh_sponsors]: https://github.com/sponsors/pboling
