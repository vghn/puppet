# Change Log

## [Unreleased](https://github.com/vghn/puppet/tree/HEAD)

[Full Changelog](https://github.com/vghn/puppet/compare/v0.1.12...HEAD)

**Implemented enhancements:**

- Use `$facts\[\]` instead of global variables [\#66](https://github.com/vghn/puppet/issues/66)
- Replace `create\_resources` with iterations [\#64](https://github.com/vghn/puppet/issues/64)
- Replace `validate\_` functions with Puppet 4 data types [\#62](https://github.com/vghn/puppet/issues/62)
- Clean-up hooks [\#61](https://github.com/vghn/puppet/issues/61)
- Move RSpec tests into the root of the control repo [\#59](https://github.com/vghn/puppet/issues/59)
- Refactor acceptance testing [\#68](https://github.com/vghn/puppet/pull/68) ([vladgh](https://github.com/vladgh))
- Clean-up Control Repo [\#60](https://github.com/vghn/puppet/pull/60) ([vladgh](https://github.com/vladgh))
- Upgrade docker compose [\#58](https://github.com/vghn/puppet/pull/58) ([vladgh](https://github.com/vladgh))
- Update puppet modules [\#53](https://github.com/vghn/puppet/pull/53) ([vladgh](https://github.com/vladgh))

**Fixed bugs:**

- aws sync does not download one byte changes [\#56](https://github.com/vghn/puppet/issues/56)
- Docker module reinstalls old linux kernel packages \(after apt updates them\) [\#54](https://github.com/vghn/puppet/issues/54)
- Add exact timestamps to aws sync command [\#57](https://github.com/vghn/puppet/pull/57) ([vladgh](https://github.com/vladgh))
- Docker should not manage kernel [\#55](https://github.com/vghn/puppet/pull/55) ([vladgh](https://github.com/vladgh))

**Merged pull requests:**

- Use `$facts\[\]` instead of global variables [\#67](https://github.com/vghn/puppet/pull/67) ([vladgh](https://github.com/vladgh))
- Improve iterations [\#65](https://github.com/vghn/puppet/pull/65) ([vladgh](https://github.com/vladgh))
- Remove validate\_array function [\#63](https://github.com/vghn/puppet/pull/63) ([vladgh](https://github.com/vladgh))

## [v0.1.12](https://github.com/vghn/puppet/tree/v0.1.12) (2016-09-18)
[Full Changelog](https://github.com/vghn/puppet/compare/v0.1.11...v0.1.12)

**Implemented enhancements:**

- Add rubycritic and reek [\#52](https://github.com/vghn/puppet/issues/52)

## [v0.1.11](https://github.com/vghn/puppet/tree/v0.1.11) (2016-08-27)
[Full Changelog](https://github.com/vghn/puppet/compare/v0.1.10...v0.1.11)

**Implemented enhancements:**

- The r10k:dependencies should check git modules too [\#51](https://github.com/vghn/puppet/issues/51)
- Install modules from GitHub [\#50](https://github.com/vghn/puppet/issues/50)
- Use parallel testing [\#49](https://github.com/vghn/puppet/issues/49)

**Fixed bugs:**

- Fix deploy command [\#48](https://github.com/vghn/puppet/issues/48)

## [v0.1.10](https://github.com/vghn/puppet/tree/v0.1.10) (2016-08-22)
[Full Changelog](https://github.com/vghn/puppet/compare/v0.1.9...v0.1.10)

**Implemented enhancements:**

- Explicitly reject the connection if backend servers are down [\#42](https://github.com/vghn/puppet/issues/42)

**Merged pull requests:**

- Add the 'ogstor' role [\#47](https://github.com/vghn/puppet/pull/47) ([vladgh](https://github.com/vladgh))

## [v0.1.9](https://github.com/vghn/puppet/tree/v0.1.9) (2016-08-22)
[Full Changelog](https://github.com/vghn/puppet/compare/v0.1.8...v0.1.9)

**Implemented enhancements:**

- Terminate SSL at LB level [\#43](https://github.com/vghn/puppet/issues/43)
- Create a profile for small changes [\#38](https://github.com/vghn/puppet/issues/38)

**Fixed bugs:**

- Fix gem dependecies [\#41](https://github.com/vghn/puppet/issues/41)
- Restart service in profile::misc [\#40](https://github.com/vghn/puppet/issues/40)

**Merged pull requests:**

- Terminate SSL at LB level [\#44](https://github.com/vghn/puppet/pull/44) ([vladgh](https://github.com/vladgh))
- Add profile::misc [\#39](https://github.com/vghn/puppet/pull/39) ([vladgh](https://github.com/vladgh))

## [v0.1.8](https://github.com/vghn/puppet/tree/v0.1.8) (2016-08-20)
[Full Changelog](https://github.com/vghn/puppet/compare/v0.1.7...v0.1.8)

**Implemented enhancements:**

- Bootstrap script should check if apt repo is installed [\#34](https://github.com/vghn/puppet/issues/34)
- Add a cron job during maintenance window to update everything \(repo, docker images, restart containers\) [\#27](https://github.com/vghn/puppet/issues/27)

**Fixed bugs:**

- Remove MaxPermSize from docker-compose.yml [\#35](https://github.com/vghn/puppet/issues/35)
- Fix acceptance tests [\#32](https://github.com/vghn/puppet/issues/32)

**Merged pull requests:**

- Rename all shared example files [\#37](https://github.com/vghn/puppet/pull/37) ([vladgh](https://github.com/vladgh))
- Update docker-compose.yml [\#36](https://github.com/vghn/puppet/pull/36) ([vladgh](https://github.com/vladgh))

## [v0.1.7](https://github.com/vghn/puppet/tree/v0.1.7) (2016-08-20)
[Full Changelog](https://github.com/vghn/puppet/compare/v0.1.6...v0.1.7)

**Implemented enhancements:**

- Add hardening modules [\#28](https://github.com/vghn/puppet/issues/28)
- Replace profile::swap with a puppet approved module [\#24](https://github.com/vghn/puppet/issues/24)
- Simplify the release task [\#31](https://github.com/vghn/puppet/pull/31) ([vladgh](https://github.com/vladgh))
- Replace profile::swap with a puppet approved module [\#30](https://github.com/vghn/puppet/pull/30) ([vladgh](https://github.com/vladgh))
- Start using the puppetlabs/accounts module [\#25](https://github.com/vghn/puppet/pull/25) ([vladgh](https://github.com/vladgh))

**Merged pull requests:**

- Replace SSH module [\#33](https://github.com/vghn/puppet/pull/33) ([vladgh](https://github.com/vladgh))

## [v0.1.6](https://github.com/vghn/puppet/tree/v0.1.6) (2016-08-20)
[Full Changelog](https://github.com/vghn/puppet/compare/v0.1.5...v0.1.6)

**Implemented enhancements:**

- Replace VGS release scripts, with a simpler rake task [\#29](https://github.com/vghn/puppet/issues/29)
- Add cronjob to clean RHEA instance [\#26](https://github.com/vghn/puppet/issues/26)

## [v0.1.5](https://github.com/vghn/puppet/tree/v0.1.5) (2016-08-19)
[Full Changelog](https://github.com/vghn/puppet/compare/v0.1.4...v0.1.5)

## [v0.1.4](https://github.com/vghn/puppet/tree/v0.1.4) (2016-08-19)
[Full Changelog](https://github.com/vghn/puppet/compare/v0.1.3...v0.1.4)

## [v0.1.3](https://github.com/vghn/puppet/tree/v0.1.3) (2016-08-18)
[Full Changelog](https://github.com/vghn/puppet/compare/v0.1.2...v0.1.3)

## [v0.1.2](https://github.com/vghn/puppet/tree/v0.1.2) (2016-08-18)
[Full Changelog](https://github.com/vghn/puppet/compare/v0.1.1...v0.1.2)

## [v0.1.1](https://github.com/vghn/puppet/tree/v0.1.1) (2016-08-17)
[Full Changelog](https://github.com/vghn/puppet/compare/v0.1.0...v0.1.1)



\* *This Change Log was automatically generated by [github_changelog_generator](https://github.com/skywinder/Github-Changelog-Generator)*