# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com//), and this project adheres to [Semantic Versioning](https://semver.org/).

## [2.0.0] - 2025-02-23

The change here is that at attribute's value is no longer mutated in place; a
copy is mutated instead. This should not be a breaking change for most, but
it's a big enough change to warrant the major version bump, just in case a
deployment relied on the prior behavior.

- Use frozen string literals and regex constants to reduce allocations ([#63])
- Limit concurrent-ruby in build matrix for activemodels <= 7.0 ([#79])
- Avoid string mutation for Ruby 3.4 ([#76], [#77], [#64])
- Optimize string allocation during mutation ([#80])

## [1.14.1] - 2024-12-10

- `funding_uri` added to gemspec

## [1.14.0] - 2024-11-10

- Adds Rails 8 support ([#73], [#74])
- Refactor and cleanup option handling ([#69])
- Adds Ruby 3.2 and 3.3 support ([#65], [#70])

## [1.13.0] - 2022-05-13

- Added a matcher for `replace_newlines` ([#62])
- Added Ruby 3.1 support

## [1.12.0] - 2021-12-20

- Switches to GitHub CI Workflows
- Adds support for Rails 7.0 ([#58] and [#59]).

## [1.11.0] - 2020-04-02

- Prevent stripping frozen values ([#53])

## [1.10.1] - 2020-04-02

- Fix strip behavior for frozen values ([#53])

NOTE: This fix is backwards incompatible, but a future version will avoid stripping frozen values altogether.

## [1.10.0] - 2020-03-31

- Clean up and remove (now) redundant #respond_to? calls ([#49])
- Legacy and deprecation cleanup ([#50])
- Update matcher to take list of arguments; alias it as #strip_attributes ([#52])

## [1.9.2] - 2020-02-16

- Fix regression in 1.9.1: Arrays & Hashes now become nil ([#48])

## [1.9.1] - 2020-02-14

- Add official Ruby 2.7 support ([#45])
- Zero-width space doesn't result in nil after stripping ([#46])
- Fix zero width space strip to nil ([#47])

## [1.9.0] - 2019-02-24

- Adds `:if` and `:unless` options ([#37])

## [1.8.1] - 2019-01-22

- Add Rails 6 compatibility ([#36])

## [1.8.0] - 2016-06-02

Added multibyte whitespace support to `:collapse_spaces` option ([#32])

## [1.7.1] - 2015-08-24

- Avoid Encoding::CompatibilityError when handling binary column ([#29])

## [1.7.0] - 2015-02-10

- Added option to remove all newlines ([#27]) `:replace_newlines`

## [1.6.0] - 2015-01-23

- Refactored to expose `StripeAttributes.strip`
- Added fallback to `String#strip` for non-multibyte support

## [1.5.1] - 2014-03-25

- Updated matcher signatures to account for RSpec 3


## [1.5.0] - 2014-01-16

- Add regular expression support ([#14])
- Handle Unicode whitespace and invisible characters ([#15])

## [1.4.4] - untracked

## [1.4.3] - untracked

## [1.4.2] - untracked

## [1.4.1] - untracked

## [1.4.0] - untracked

## [1.3.0] - untracked

## [1.2.0] - untracked

## [1.1.1] - untracked

## [1.1.0] - untracked

## [1.0.3] - untracked

## [1.0.2] - untracked

## [1.0.1] - untracked

## [1.0.0] - untracked

## [0.9.0] - untracked

[Unreleased]: https://github.com/rmm5t/strip_attributes/compare/v1.15.0..HEAD
[1.15.0]: https://github.com/rmm5t/strip_attributes/compare/v1.14.1..v1.15.0
[1.14.1]: https://github.com/rmm5t/strip_attributes/compare/v1.14.0..v1.14.1
[1.14.0]: https://github.com/rmm5t/strip_attributes/compare/v1.13.0..v1.14.0
[1.13.0]: https://github.com/rmm5t/strip_attributes/compare/v1.12.0..v1.13.0
[1.12.0]: https://github.com/rmm5t/strip_attributes/compare/v1.11.0..v1.12.0
[1.11.0]: https://github.com/rmm5t/strip_attributes/compare/v1.10.1..v1.11.0
[1.10.1]: https://github.com/rmm5t/strip_attributes/compare/v1.10.0..v1.10.1
[1.10.0]: https://github.com/rmm5t/strip_attributes/compare/v1.9.2..v1.10.0
[1.9.2]: https://github.com/rmm5t/strip_attributes/compare/v1.9.1..v1.9.2
[1.9.1]: https://github.com/rmm5t/strip_attributes/compare/v1.9.0..v1.9.1
[1.9.0]: https://github.com/rmm5t/strip_attributes/compare/v1.8.1..v1.9.0
[1.8.1]: https://github.com/rmm5t/strip_attributes/compare/v1.8.0..v1.8.1
[1.8.0]: https://github.com/rmm5t/strip_attributes/compare/v1.7.1..v1.8.0
[1.7.1]: https://github.com/rmm5t/strip_attributes/compare/v1.7.0..v1.7.1
[1.7.0]: https://github.com/rmm5t/strip_attributes/compare/v1.6.0..v1.7.0
[1.6.0]: https://github.com/rmm5t/strip_attributes/compare/v1.5.1..v1.6.0
[1.5.1]: https://github.com/rmm5t/strip_attributes/compare/v1.5.0..v1.5.1
[1.5.0]: https://github.com/rmm5t/strip_attributes/compare/v1.4.4..v1.5.0
[1.4.4]: https://github.com/rmm5t/strip_attributes/compare/v1.4.3..v1.4.4
[1.4.3]: https://github.com/rmm5t/strip_attributes/compare/v1.4.2..v1.4.3
[1.4.2]: https://github.com/rmm5t/strip_attributes/compare/v1.4.1..v1.4.2
[1.4.1]: https://github.com/rmm5t/strip_attributes/compare/v1.4.0..v1.4.1
[1.4.0]: https://github.com/rmm5t/strip_attributes/compare/v1.3.0..v1.4.0
[1.3.0]: https://github.com/rmm5t/strip_attributes/compare/v1.2.0..v1.3.0
[1.2.0]: https://github.com/rmm5t/strip_attributes/compare/v1.1.1..v1.2.0
[1.1.1]: https://github.com/rmm5t/strip_attributes/compare/v1.1.0..v1.1.1
[1.1.0]: https://github.com/rmm5t/strip_attributes/compare/v1.0.3..v1.1.0
[1.0.3]: https://github.com/rmm5t/strip_attributes/compare/v1.0.2..v1.0.3
[1.0.2]: https://github.com/rmm5t/strip_attributes/compare/v1.0.1..v1.0.2
[1.0.1]: https://github.com/rmm5t/strip_attributes/compare/v1.0.0..v1.0.1
[1.0.0]: https://github.com/rmm5t/strip_attributes/compare/v0.9.0..v1.0.0
[0.9.0]: https://github.com/rmm5t/strip_attributes/compare/a78b807..v0.9.0

[#80]: https://github.com/rmm5t/strip_attributes/pull/80
[#79]: https://github.com/rmm5t/strip_attributes/pull/79
[#77]: https://github.com/rmm5t/strip_attributes/pull/77
[#76]: https://github.com/rmm5t/strip_attributes/issues/76
[#74]: https://github.com/rmm5t/strip_attributes/pull/74
[#73]: https://github.com/rmm5t/strip_attributes/pull/73
[#70]: https://github.com/rmm5t/strip_attributes/pull/70
[#69]: https://github.com/rmm5t/strip_attributes/pull/69
[#65]: https://github.com/rmm5t/strip_attributes/pull/65
[#64]: https://github.com/rmm5t/strip_attributes/pull/64
[#63]: https://github.com/rmm5t/strip_attributes/pull/63
[#62]: https://github.com/rmm5t/strip_attributes/pull/62
[#58]: https://github.com/rmm5t/strip_attributes/pull/58
[#59]: https://github.com/rmm5t/strip_attributes/pull/59
[#53]: https://github.com/rmm5t/strip_attributes/issues/53
[#49]: https://github.com/rmm5t/strip_attributes/pull/49
[#50]: https://github.com/rmm5t/strip_attributes/pull/50
[#52]: https://github.com/rmm5t/strip_attributes/pull/52
[#48]: https://github.com/rmm5t/strip_attributes/pull/48
[#45]: https://github.com/rmm5t/strip_attributes/pull/45
[#46]: https://github.com/rmm5t/strip_attributes/pull/46
[#47]: https://github.com/rmm5t/strip_attributes/pull/47
[#37]: https://github.com/rmm5t/strip_attributes/pull/37
[#36]: https://github.com/rmm5t/strip_attributes/pull/36
[#32]: https://github.com/rmm5t/strip_attributes/pull/32
[#29]: https://github.com/rmm5t/strip_attributes/pull/29
[#27]: https://github.com/rmm5t/strip_attributes/pull/27
[#14]: https://github.com/rmm5t/strip_attributes/pull/14
[#15]: https://github.com/rmm5t/strip_attributes/pull/15
