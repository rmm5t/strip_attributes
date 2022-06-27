# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com//), and this project adheres to [Semantic Versioning](https://semver.org/).

## [Unreleased] - TBD

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

[Unreleased]: https://github.com/rmm5t/strip_attributes/compare/v1.13.0..HEAD
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
