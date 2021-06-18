# Changelog
All notable changes to this project will be documented in this file.

## [0.0.8] - 2021-06-18

### Added
  - rubocop
  - fixed all the cop violations
  - github workflow for rubocop

## [0.0.7] - 2021-06-10

### Fixed
  - Implement missing `remind` method in `Envelope`

## [0.0.6] - 2021-05-27

### Added
  - Add a wrapper of the `/remind` endpoint for the "Envelopes" resource on the Signable API.
  - Setup a GitHub Action to run `bundle exec rspec` upon pushes to pull requests branches.
  - Improve test suite by adding VCR and recording initial cassettes.
  - Document new testing procedures in README.md
