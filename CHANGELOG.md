# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]
### Added
### Changed
### Fixed
### Removed

## [1.0.0] - 2023-10-17
### Added
- `pftf` now accepts a block, and when given:
    - `[BEG] #{msg}#{value}` is logged before executing the block
    - `[FIN] #{msg}#{value}` is logged after executing the block
- options hash as fourth parameter to `pftf`!
    - `:rescue_logged` - Error classes that should be rescued and logged. Default: `[]`
    - `:backtrace_logged` - When truthy, rescued errors log a full backtrace. Default: `nil`
    - `:reraise` - When truthy, rescued errors will be re-raised. Default: `nil`
    - `:benchmark` - When truthy, prints realtime spent executing block. Default: `nil`
- 100% Test Line Coverage of all new features, and existing code
### Changed
- `VERSION` constant is now located at `PrettyFeed::Version::VERSION`
### Fixed
- Errors in documentation

## [0.2.0] - 2022-03-21
### Fixed
- Corrected misleading documentation

## [0.1.1] - 2022-03-21
### Added
- 100% test coverage
### Changed
- Improved `warn` text when stub color methods added to instances of String.
### Fixed
- Handling of frozen strings

## [0.1.0] - 2022-03-21
### Added
- Initial Release

[Unreleased]: https://github.com/pboling/pretty_feed/-/compare/v1.0.0...HEAD
[1.0.0]: https://github.com/pboling/pretty_feed/-/compare/v0.2.0...v1.0.0
[0.2.0]: https://github.com/pboling/pretty_feed/-/compare/v0.1.1...v0.2.0
[0.1.1]: https://github.com/pboling/pretty_feed/-/compare/v0.1.0...v0.1.1
[0.1.0]: https://github.com/pboling/pretty_feed/-/compare/cd45565324085939b680c8597599828b4c41511f...v0.1.0
