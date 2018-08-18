# Change Log

## [v0.4.0](https://github.com/vghn/puppet/tree/v0.4.0) (2018-08-18)
[Full Changelog](https://github.com/vghn/puppet/compare/v0.3.1...v0.4.0)

**Implemented enhancements:**

- Add essential packages to all servers [\#242](https://github.com/vghn/puppet/issues/242)
- Default to hostname if instance id is absent [\#241](https://github.com/vghn/puppet/issues/241)
- Add Cosmin user [\#240](https://github.com/vghn/puppet/issues/240)
- Use stable docker-ce package by default [\#239](https://github.com/vghn/puppet/issues/239)
- Use official vagrant boxes for acceptance testing [\#238](https://github.com/vghn/puppet/issues/238)
- Support Ubuntu 18.04 Bionic Beaver [\#237](https://github.com/vghn/puppet/issues/237)
- Use Forge modules in the Puppetfile [\#236](https://github.com/vghn/puppet/issues/236)
- Add GPG keys to servers [\#235](https://github.com/vghn/puppet/issues/235)
- Update dependencies in the Puppetfile [\#234](https://github.com/vghn/puppet/issues/234)
- Improve bootstrap script [\#233](https://github.com/vghn/puppet/issues/233)
- Bootstrap should have an install only option [\#232](https://github.com/vghn/puppet/issues/232)
- Eliminate the VGS dependency [\#231](https://github.com/vghn/puppet/issues/231)
- Add 3rd party repos to unattended upgrades [\#229](https://github.com/vghn/puppet/issues/229)

**Fixed bugs:**

- Do not show diff by default in logs [\#243](https://github.com/vghn/puppet/issues/243)
- Fix test for the monitor class [\#230](https://github.com/vghn/puppet/issues/230)
- Node exporter ignore mount points [\#228](https://github.com/vghn/puppet/issues/228)

## [v0.3.1](https://github.com/vghn/puppet/tree/v0.3.1) (2018-02-11)
[Full Changelog](https://github.com/vghn/puppet/compare/v0.3.0...v0.3.1)

**Implemented enhancements:**

- Node exporter on Rhea should collect textfile metrics from folder [\#227](https://github.com/vghn/puppet/issues/227)
- Test Prometheus Report Processor [\#226](https://github.com/vghn/puppet/issues/226)
- Test increasing test concurrency [\#225](https://github.com/vghn/puppet/issues/225)

**Fixed bugs:**

- Disable xconsole in VPI's RSysLog [\#224](https://github.com/vghn/puppet/issues/224)

## [v0.3.0](https://github.com/vghn/puppet/tree/v0.3.0) (2018-02-02)
[Full Changelog](https://github.com/vghn/puppet/compare/v0.2.2...v0.3.0)

**Implemented enhancements:**

- Do not manage docker on VPI [\#222](https://github.com/vghn/puppet/issues/222)
- Allow docker profile on the entire Debian family [\#220](https://github.com/vghn/puppet/issues/220)
- Add option to use system git [\#219](https://github.com/vghn/puppet/issues/219)
- Add VPI role [\#213](https://github.com/vghn/puppet/issues/213)
- Improve CSR attributes generation [\#212](https://github.com/vghn/puppet/issues/212)
- Dotfiles and VGS should be cloned by the right user [\#211](https://github.com/vghn/puppet/issues/211)
- Rate limit SSH [\#210](https://github.com/vghn/puppet/issues/210)
- Replace dotfiles and vgs classes with a simple call in Hiera [\#209](https://github.com/vghn/puppet/issues/209)
- Mini should install it's own docker package [\#208](https://github.com/vghn/puppet/issues/208)
- Create a simple dotfiles class [\#207](https://github.com/vghn/puppet/issues/207)
- Disable TCP and REPL protocols for the RSysLog Relay Server [\#206](https://github.com/vghn/puppet/issues/206)
- The log profile should create a relay server [\#205](https://github.com/vghn/puppet/issues/205)
- Fix acceptance tests to work for both roles and profiles [\#204](https://github.com/vghn/puppet/issues/204)
- Specify beaker dependencies [\#203](https://github.com/vghn/puppet/issues/203)
- Add Prometheus role [\#202](https://github.com/vghn/puppet/issues/202)
- Add swap file to Rhea [\#201](https://github.com/vghn/puppet/issues/201)
- Remove JQ version parameter [\#200](https://github.com/vghn/puppet/issues/200)
- Only open specific ports for Prometheus [\#199](https://github.com/vghn/puppet/issues/199)
- Create a separate profile for CA certificates [\#194](https://github.com/vghn/puppet/issues/194)
- Use the updated TravisCI images [\#193](https://github.com/vghn/puppet/issues/193)
- Do not remove all unused images on docker hosts [\#192](https://github.com/vghn/puppet/issues/192)
- SSH ED25519 support for integration tests [\#190](https://github.com/vghn/puppet/issues/190)
- Upgrade Ruby to 2.4.2 [\#186](https://github.com/vghn/puppet/issues/186)
- Improve environment [\#185](https://github.com/vghn/puppet/issues/185)
- EFS profile should install NFS package even if mount target/point is not defined [\#181](https://github.com/vghn/puppet/issues/181)
- N/A [\#179](https://github.com/vghn/puppet/issues/179)
- Simplify node classification by only allowing a trusted role [\#178](https://github.com/vghn/puppet/issues/178)
- Use default paths for Hiera EYAML keys [\#177](https://github.com/vghn/puppet/issues/177)
- Continue to use garethr-docker repo [\#174](https://github.com/vghn/puppet/issues/174)
- Cache gems and puppet modules in TravisCI  [\#172](https://github.com/vghn/puppet/issues/172)
- Create monitoring class [\#198](https://github.com/vghn/puppet/pull/198) ([vladgh](https://github.com/vladgh))
- Log to logs.ghn.me with TLS [\#188](https://github.com/vghn/puppet/pull/188) ([vladgh](https://github.com/vladgh))
- Use the new Puppet Docker module [\#187](https://github.com/vghn/puppet/pull/187) ([vladgh](https://github.com/vladgh))
- Switch to new Bundler file names [\#184](https://github.com/vghn/puppet/pull/184) ([vladgh](https://github.com/vladgh))
- Use the $facts hash everywhere for a cleaner namespace [\#180](https://github.com/vghn/puppet/pull/180) ([vladgh](https://github.com/vladgh))
- Use R10K to install test modules [\#171](https://github.com/vghn/puppet/pull/171) ([vladgh](https://github.com/vladgh))

**Fixed bugs:**

- Fix PATH in Puppet Agent cronjob [\#223](https://github.com/vghn/puppet/issues/223)
- Fix docker install on VPI [\#221](https://github.com/vghn/puppet/issues/221)
- Base should include git only if vcsrepos are present [\#218](https://github.com/vghn/puppet/issues/218)
- Fix packages array in the base profile [\#217](https://github.com/vghn/puppet/issues/217)
- Bootstrap script should ensure config dir [\#216](https://github.com/vghn/puppet/issues/216)
- Bootstrap script should skip installing agent if already installed [\#215](https://github.com/vghn/puppet/issues/215)
- Remove manage\_kernel from docker profile [\#214](https://github.com/vghn/puppet/issues/214)
- Fix extra CA certificates [\#197](https://github.com/vghn/puppet/issues/197)
- Fix CA certificates [\#196](https://github.com/vghn/puppet/issues/196)
- Upgrade firewall module to master [\#195](https://github.com/vghn/puppet/issues/195)
- Fix IPTables integration tests [\#191](https://github.com/vghn/puppet/issues/191)
- Monitoring log files should not depend on server/port [\#189](https://github.com/vghn/puppet/issues/189)
- Travis gem brings unwanted dependencies [\#182](https://github.com/vghn/puppet/issues/182)
- Fix facts in rspec tests [\#175](https://github.com/vghn/puppet/issues/175)
- Pin gem versions [\#183](https://github.com/vghn/puppet/pull/183) ([vladgh](https://github.com/vladgh))
- Add a custom Docker class [\#176](https://github.com/vghn/puppet/pull/176) ([vladgh](https://github.com/vladgh))
- Remove Simplecov for now [\#173](https://github.com/vghn/puppet/pull/173) ([vladgh](https://github.com/vladgh))

## [v0.2.2](https://github.com/vghn/puppet/tree/v0.2.2) (2017-07-11)
[Full Changelog](https://github.com/vghn/puppet/compare/v0.2.1...v0.2.2)

**Implemented enhancements:**

- Improve bootstrap usage instructions [\#170](https://github.com/vghn/puppet/issues/170)
- Adhere to recommended community standards [\#169](https://github.com/vghn/puppet/issues/169)
- Improve lookup functions [\#168](https://github.com/vghn/puppet/issues/168)
- Use the new Puppet rolling repos [\#167](https://github.com/vghn/puppet/issues/167)
- Simplify Puppet bootstrap script [\#166](https://github.com/vghn/puppet/issues/166)
- Use the containerized TravisCI environment [\#164](https://github.com/vghn/puppet/issues/164)
- Use the new docker package [\#162](https://github.com/vghn/puppet/issues/162)
- Update docker-compose [\#161](https://github.com/vghn/puppet/issues/161)
- Switch to Puppet 5 [\#160](https://github.com/vghn/puppet/issues/160)

**Fixed bugs:**

- Pin down docker repository architecture [\#165](https://github.com/vghn/puppet/issues/165)
- Remove docker profile until the module is updated [\#163](https://github.com/vghn/puppet/issues/163)

## [v0.2.1](https://github.com/vghn/puppet/tree/v0.2.1) (2017-06-06)
[Full Changelog](https://github.com/vghn/puppet/compare/v0.2.0...v0.2.1)

**Implemented enhancements:**

- Configure Samba to use at least SMBv2 [\#156](https://github.com/vghn/puppet/issues/156)
- Run docker system prune in a cron job [\#158](https://github.com/vghn/puppet/pull/158) ([vladgh](https://github.com/vladgh))
- Add bryana/ec2tagfacts and puppetlabs/motd modules [\#157](https://github.com/vghn/puppet/pull/157) ([vladgh](https://github.com/vladgh))
- Module and gem updates [\#155](https://github.com/vghn/puppet/pull/155) ([vladgh](https://github.com/vladgh))
- Read Hiera-EYAML keys from Docker Secrets [\#154](https://github.com/vghn/puppet/pull/154) ([vladgh](https://github.com/vladgh))
- Update Readme [\#153](https://github.com/vghn/puppet/pull/153) ([vladgh](https://github.com/vladgh))
- Update modules [\#152](https://github.com/vghn/puppet/pull/152) ([vladgh](https://github.com/vladgh))
- Minor changes [\#151](https://github.com/vghn/puppet/pull/151) ([vladgh](https://github.com/vladgh))
- Update Tasks options [\#150](https://github.com/vghn/puppet/pull/150) ([vladgh](https://github.com/vladgh))
- Automatically update apt packages [\#149](https://github.com/vghn/puppet/pull/149) ([vladgh](https://github.com/vladgh))

**Fixed bugs:**

- Remove ec2tagfacts module [\#159](https://github.com/vghn/puppet/issues/159)

## [v0.2.0](https://github.com/vghn/puppet/tree/v0.2.0) (2017-04-20)
[Full Changelog](https://github.com/vghn/puppet/compare/v0.1.17...v0.2.0)

**Implemented enhancements:**

- Module updates [\#148](https://github.com/vghn/puppet/pull/148) ([vladgh](https://github.com/vladgh))
- Upgrade Docker Compose [\#147](https://github.com/vghn/puppet/pull/147) ([vladgh](https://github.com/vladgh))
- Improve pre-commit hook [\#146](https://github.com/vghn/puppet/pull/146) ([vladgh](https://github.com/vladgh))
- Add DEBUG global variable [\#145](https://github.com/vghn/puppet/pull/145) ([vladgh](https://github.com/vladgh))
- Remove Faraday gem version requirement [\#144](https://github.com/vghn/puppet/pull/144) ([vladgh](https://github.com/vladgh))
- Use the new release task options [\#142](https://github.com/vghn/puppet/pull/142) ([vladgh](https://github.com/vladgh))
- Add docker cleanup cron jobs [\#141](https://github.com/vghn/puppet/pull/141) ([vladgh](https://github.com/vladgh))
- Update modules [\#139](https://github.com/vghn/puppet/pull/139) ([vladgh](https://github.com/vladgh))
- Migrate to Vtasks [\#138](https://github.com/vghn/puppet/pull/138) ([vladgh](https://github.com/vladgh))
- Update README [\#137](https://github.com/vghn/puppet/pull/137) ([vladgh](https://github.com/vladgh))
- Allow port 80 [\#136](https://github.com/vghn/puppet/pull/136) ([vladgh](https://github.com/vladgh))
- Update README [\#135](https://github.com/vghn/puppet/pull/135) ([vladgh](https://github.com/vladgh))
- Clean-up ssh keys [\#134](https://github.com/vghn/puppet/pull/134) ([vladgh](https://github.com/vladgh))
- Add Vlad's public key to the ubuntu user [\#133](https://github.com/vghn/puppet/pull/133) ([vladgh](https://github.com/vladgh))
- Improve rake tasks [\#131](https://github.com/vghn/puppet/pull/131) ([vladgh](https://github.com/vladgh))
- Upgrade modules [\#130](https://github.com/vghn/puppet/pull/130) ([vladgh](https://github.com/vladgh))
- Use shared paths in acceptance tests [\#129](https://github.com/vghn/puppet/pull/129) ([vladgh](https://github.com/vladgh))
- Hiera v5 [\#128](https://github.com/vghn/puppet/pull/128) ([vladgh](https://github.com/vladgh))
- Add Hiera EYaml V5 [\#127](https://github.com/vghn/puppet/pull/127) ([vladgh](https://github.com/vladgh))
- No trailing new line for the sudoers file [\#126](https://github.com/vghn/puppet/pull/126) ([vladgh](https://github.com/vladgh))
- Improve ssh and sudo settings [\#125](https://github.com/vghn/puppet/pull/125) ([vladgh](https://github.com/vladgh))
- Allow adding users in the base profile [\#123](https://github.com/vghn/puppet/pull/123) ([vladgh](https://github.com/vladgh))
- Improve output on the release rake task [\#122](https://github.com/vghn/puppet/pull/122) ([vladgh](https://github.com/vladgh))

**Fixed bugs:**

- Pin faraday gem version and fix test task [\#143](https://github.com/vghn/puppet/pull/143) ([vladgh](https://github.com/vladgh))
- Fix chaining arrow syntax [\#140](https://github.com/vghn/puppet/pull/140) ([vladgh](https://github.com/vladgh))
- Remove docker system prune cron jobs [\#132](https://github.com/vghn/puppet/pull/132) ([vladgh](https://github.com/vladgh))
- Default to BASH shell for new users [\#124](https://github.com/vghn/puppet/pull/124) ([vladgh](https://github.com/vladgh))

## [v0.1.17](https://github.com/vghn/puppet/tree/v0.1.17) (2017-02-25)
[Full Changelog](https://github.com/vghn/puppet/compare/v0.1.16...v0.1.17)

**Implemented enhancements:**

- Clean-up [\#120](https://github.com/vghn/puppet/pull/120) ([vladgh](https://github.com/vladgh))
- Upgrades [\#118](https://github.com/vghn/puppet/pull/118) ([vladgh](https://github.com/vladgh))
- Update SSH configuration for Green [\#117](https://github.com/vghn/puppet/pull/117) ([vladgh](https://github.com/vladgh))
- Clean-up ssh keys [\#115](https://github.com/vghn/puppet/pull/115) ([vladgh](https://github.com/vladgh))
- Add Green Role [\#114](https://github.com/vghn/puppet/pull/114) ([vladgh](https://github.com/vladgh))
- Improve acceptance tests [\#113](https://github.com/vghn/puppet/pull/113) ([vladgh](https://github.com/vladgh))
- Miscellaneous improvements  [\#112](https://github.com/vghn/puppet/pull/112) ([vladgh](https://github.com/vladgh))
- Add ShirtAve share [\#111](https://github.com/vghn/puppet/pull/111) ([vladgh](https://github.com/vladgh))
- Improve tests [\#110](https://github.com/vghn/puppet/pull/110) ([vladgh](https://github.com/vladgh))
- Upgrade to Hiera 5 [\#109](https://github.com/vghn/puppet/pull/109) ([vladgh](https://github.com/vladgh))
- Upgrades [\#108](https://github.com/vghn/puppet/pull/108) ([vladgh](https://github.com/vladgh))
- Remove direct reference to semantic puppet [\#106](https://github.com/vghn/puppet/pull/106) ([vladgh](https://github.com/vladgh))
- Improve Rake tasks and documentation [\#105](https://github.com/vghn/puppet/pull/105) ([vladgh](https://github.com/vladgh))
- Use Hiera EYaml [\#104](https://github.com/vghn/puppet/pull/104) ([vladgh](https://github.com/vladgh))
- Remove command to delete .env from S3 [\#103](https://github.com/vghn/puppet/pull/103) ([vladgh](https://github.com/vladgh))
- Update modules and docker compose [\#102](https://github.com/vghn/puppet/pull/102) ([vladgh](https://github.com/vladgh))

**Fixed bugs:**

- Fix release tasks in Rakefile [\#121](https://github.com/vghn/puppet/pull/121) ([vladgh](https://github.com/vladgh))
- Bring back RSA ssh keys [\#119](https://github.com/vghn/puppet/pull/119) ([vladgh](https://github.com/vladgh))
- Fix whitespace in ssh public keys [\#116](https://github.com/vghn/puppet/pull/116) ([vladgh](https://github.com/vladgh))
- Fork the docker module to get rif of deprecations [\#107](https://github.com/vghn/puppet/pull/107) ([vladgh](https://github.com/vladgh))

## [v0.1.16](https://github.com/vghn/puppet/tree/v0.1.16) (2017-01-15)
[Full Changelog](https://github.com/vghn/puppet/compare/v0.1.15...v0.1.16)

**Implemented enhancements:**

- Upgrade modules [\#101](https://github.com/vghn/puppet/pull/101) ([vladgh](https://github.com/vladgh))
- Fix logs [\#99](https://github.com/vghn/puppet/pull/99) ([vladgh](https://github.com/vladgh))
- Add task to sync environment with TravisCI [\#98](https://github.com/vghn/puppet/pull/98) ([vladgh](https://github.com/vladgh))
- Use default Ruby version for TravisCI [\#97](https://github.com/vghn/puppet/pull/97) ([vladgh](https://github.com/vladgh))
- Use the new Trusty build container in TravisCI [\#96](https://github.com/vghn/puppet/pull/96) ([vladgh](https://github.com/vladgh))

**Fixed bugs:**

- Remove Docker package pinning [\#100](https://github.com/vghn/puppet/pull/100) ([vladgh](https://github.com/vladgh))

## [v0.1.15](https://github.com/vghn/puppet/tree/v0.1.15) (2017-01-06)
[Full Changelog](https://github.com/vghn/puppet/compare/v0.1.14...v0.1.15)

**Implemented enhancements:**

- Add documentation [\#46](https://github.com/vghn/puppet/issues/46)
- Remove "essential packages" from nodes [\#45](https://github.com/vghn/puppet/issues/45)
- Consolidate rake tasks and upgrade Puppet modules [\#95](https://github.com/vghn/puppet/pull/95) ([vladgh](https://github.com/vladgh))
- Pin Ruby version in a file for RVM [\#93](https://github.com/vghn/puppet/pull/93) ([vladgh](https://github.com/vladgh))
- Update LICENSE [\#92](https://github.com/vghn/puppet/pull/92) ([vladgh](https://github.com/vladgh))
- Refactor ruby libraries and tasks [\#89](https://github.com/vghn/puppet/pull/89) ([vladgh](https://github.com/vladgh))
- Move git hooks into `./bin` and rename during install [\#88](https://github.com/vghn/puppet/pull/88) ([vladgh](https://github.com/vladgh))
- Rename folder for sensitive files to `./secure` [\#87](https://github.com/vghn/puppet/pull/87) ([vladgh](https://github.com/vladgh))
- Improve ruby libraries and rake tasks [\#86](https://github.com/vghn/puppet/pull/86) ([vladgh](https://github.com/vladgh))
- Update Puppet modules [\#85](https://github.com/vghn/puppet/pull/85) ([vladgh](https://github.com/vladgh))
- Improve S3 path declaration [\#84](https://github.com/vghn/puppet/pull/84) ([vladgh](https://github.com/vladgh))
- Fix acceptance tests [\#83](https://github.com/vghn/puppet/pull/83) ([vladgh](https://github.com/vladgh))
- Add unattended upgrades [\#82](https://github.com/vghn/puppet/pull/82) ([vladgh](https://github.com/vladgh))

**Fixed bugs:**

- Fix Travis cache [\#94](https://github.com/vghn/puppet/pull/94) ([vladgh](https://github.com/vladgh))
- Allow skipping the pre-push git hook and fix the delete\_env script [\#91](https://github.com/vghn/puppet/pull/91) ([vladgh](https://github.com/vladgh))
- Fix delete\_env script [\#90](https://github.com/vghn/puppet/pull/90) ([vladgh](https://github.com/vladgh))
- No need for ERB template on timezone [\#81](https://github.com/vghn/puppet/pull/81) ([vladgh](https://github.com/vladgh))

## [v0.1.14](https://github.com/vghn/puppet/tree/v0.1.14) (2016-12-09)
[Full Changelog](https://github.com/vghn/puppet/compare/v0.1.13...v0.1.14)

**Implemented enhancements:**

- Improvements [\#80](https://github.com/vghn/puppet/pull/80) ([vladgh](https://github.com/vladgh))

**Fixed bugs:**

- Fix firewall profile testing [\#79](https://github.com/vghn/puppet/pull/79) ([vladgh](https://github.com/vladgh))

## [v0.1.13](https://github.com/vghn/puppet/tree/v0.1.13) (2016-12-07)
[Full Changelog](https://github.com/vghn/puppet/compare/v0.1.12...v0.1.13)

**Implemented enhancements:**

- Use `$facts\[\]` instead of global variables [\#66](https://github.com/vghn/puppet/issues/66)
- Replace `create\_resources` with iterations [\#64](https://github.com/vghn/puppet/issues/64)
- Replace `validate\_` functions with Puppet 4 data types [\#62](https://github.com/vghn/puppet/issues/62)
- Clean-up hooks [\#61](https://github.com/vghn/puppet/issues/61)
- Move RSpec tests into the root of the control repo [\#59](https://github.com/vghn/puppet/issues/59)
- Module updates nad minor rake task fix [\#76](https://github.com/vghn/puppet/pull/76) ([vladgh](https://github.com/vladgh))
- Unify and improve rake tasks [\#75](https://github.com/vghn/puppet/pull/75) ([vladgh](https://github.com/vladgh))
- Improve rake tasks [\#74](https://github.com/vghn/puppet/pull/74) ([vladgh](https://github.com/vladgh))
- Improve rake tasks and hooks [\#73](https://github.com/vghn/puppet/pull/73) ([vladgh](https://github.com/vladgh))
- Add exact time stamps to aws sync commands [\#72](https://github.com/vghn/puppet/pull/72) ([vladgh](https://github.com/vladgh))
- Update R10K module [\#69](https://github.com/vghn/puppet/pull/69) ([vladgh](https://github.com/vladgh))
- Refactor acceptance testing [\#68](https://github.com/vghn/puppet/pull/68) ([vladgh](https://github.com/vladgh))
- Use `$facts\[\]` instead of global variables [\#67](https://github.com/vghn/puppet/pull/67) ([vladgh](https://github.com/vladgh))
- Improve iterations [\#65](https://github.com/vghn/puppet/pull/65) ([vladgh](https://github.com/vladgh))
- Remove validate\_array function [\#63](https://github.com/vghn/puppet/pull/63) ([vladgh](https://github.com/vladgh))
- Clean-up Control Repo [\#60](https://github.com/vghn/puppet/pull/60) ([vladgh](https://github.com/vladgh))
- Upgrade docker compose [\#58](https://github.com/vghn/puppet/pull/58) ([vladgh](https://github.com/vladgh))
- Update puppet modules [\#53](https://github.com/vghn/puppet/pull/53) ([vladgh](https://github.com/vladgh))

**Fixed bugs:**

- aws sync does not download one byte changes [\#56](https://github.com/vghn/puppet/issues/56)
- Docker module reinstalls old linux kernel packages \(after apt updates them\) [\#54](https://github.com/vghn/puppet/issues/54)
- Fix acceptance testing [\#78](https://github.com/vghn/puppet/pull/78) ([vladgh](https://github.com/vladgh))
- Fix module versions [\#77](https://github.com/vghn/puppet/pull/77) ([vladgh](https://github.com/vladgh))
- Fix tests [\#71](https://github.com/vghn/puppet/pull/71) ([vladgh](https://github.com/vladgh))
- Purge rsyslog directory on Ubuntu systems [\#70](https://github.com/vghn/puppet/pull/70) ([vladgh](https://github.com/vladgh))
- Add exact timestamps to aws sync command [\#57](https://github.com/vghn/puppet/pull/57) ([vladgh](https://github.com/vladgh))
- Docker should not manage kernel [\#55](https://github.com/vghn/puppet/pull/55) ([vladgh](https://github.com/vladgh))

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

## [v0.1.0](https://github.com/vghn/puppet/tree/v0.1.0) (2016-08-16)
[Full Changelog](https://github.com/vghn/puppet/compare/v0.0.105...v0.1.0)

## [v0.0.105](https://github.com/vghn/puppet/tree/v0.0.105) (2016-08-16)
[Full Changelog](https://github.com/vghn/puppet/compare/v0.0.104...v0.0.105)

## [v0.0.104](https://github.com/vghn/puppet/tree/v0.0.104) (2016-08-16)
[Full Changelog](https://github.com/vghn/puppet/compare/v0.0.103...v0.0.104)

## [v0.0.103](https://github.com/vghn/puppet/tree/v0.0.103) (2016-08-15)
[Full Changelog](https://github.com/vghn/puppet/compare/v0.0.102...v0.0.103)

## [v0.0.102](https://github.com/vghn/puppet/tree/v0.0.102) (2016-08-15)
[Full Changelog](https://github.com/vghn/puppet/compare/v0.0.101...v0.0.102)

## [v0.0.101](https://github.com/vghn/puppet/tree/v0.0.101) (2016-08-14)
[Full Changelog](https://github.com/vghn/puppet/compare/v0.0.100...v0.0.101)

## [v0.0.100](https://github.com/vghn/puppet/tree/v0.0.100) (2016-08-14)
[Full Changelog](https://github.com/vghn/puppet/compare/v0.0.99...v0.0.100)

## [v0.0.99](https://github.com/vghn/puppet/tree/v0.0.99) (2016-08-13)
[Full Changelog](https://github.com/vghn/puppet/compare/v0.0.98...v0.0.99)

## [v0.0.98](https://github.com/vghn/puppet/tree/v0.0.98) (2016-08-13)
[Full Changelog](https://github.com/vghn/puppet/compare/v0.0.97...v0.0.98)

## [v0.0.97](https://github.com/vghn/puppet/tree/v0.0.97) (2016-08-13)
[Full Changelog](https://github.com/vghn/puppet/compare/v0.0.96...v0.0.97)

## [v0.0.96](https://github.com/vghn/puppet/tree/v0.0.96) (2016-08-12)
[Full Changelog](https://github.com/vghn/puppet/compare/v0.0.95...v0.0.96)

**Implemented enhancements:**

- Do not hardcode puppet environment in the configuration when bootstrapping [\#23](https://github.com/vghn/puppet/issues/23)

## [v0.0.95](https://github.com/vghn/puppet/tree/v0.0.95) (2016-08-12)
[Full Changelog](https://github.com/vghn/puppet/compare/v0.0.94...v0.0.95)

**Implemented enhancements:**

- Use valid SSL certificates for the data agent [\#22](https://github.com/vghn/puppet/issues/22)

## [v0.0.94](https://github.com/vghn/puppet/tree/v0.0.94) (2016-08-12)
[Full Changelog](https://github.com/vghn/puppet/compare/v0.0.93...v0.0.94)

## [v0.0.93](https://github.com/vghn/puppet/tree/v0.0.93) (2016-08-12)
[Full Changelog](https://github.com/vghn/puppet/compare/v0.0.92...v0.0.93)

## [v0.0.92](https://github.com/vghn/puppet/tree/v0.0.92) (2016-08-12)
[Full Changelog](https://github.com/vghn/puppet/compare/v0.0.91...v0.0.92)

## [v0.0.91](https://github.com/vghn/puppet/tree/v0.0.91) (2016-08-11)
[Full Changelog](https://github.com/vghn/puppet/compare/v0.0.90...v0.0.91)

## [v0.0.90](https://github.com/vghn/puppet/tree/v0.0.90) (2016-08-10)
[Full Changelog](https://github.com/vghn/puppet/compare/v0.0.89...v0.0.90)

## [v0.0.89](https://github.com/vghn/puppet/tree/v0.0.89) (2016-08-09)
[Full Changelog](https://github.com/vghn/puppet/compare/v0.0.88...v0.0.89)

## [v0.0.88](https://github.com/vghn/puppet/tree/v0.0.88) (2016-08-04)
[Full Changelog](https://github.com/vghn/puppet/compare/v0.0.87...v0.0.88)

## [v0.0.87](https://github.com/vghn/puppet/tree/v0.0.87) (2016-08-03)
[Full Changelog](https://github.com/vghn/puppet/compare/v0.0.86...v0.0.87)

## [v0.0.86](https://github.com/vghn/puppet/tree/v0.0.86) (2016-08-02)
[Full Changelog](https://github.com/vghn/puppet/compare/v0.0.85...v0.0.86)

## [v0.0.85](https://github.com/vghn/puppet/tree/v0.0.85) (2016-08-01)
[Full Changelog](https://github.com/vghn/puppet/compare/v0.0.84...v0.0.85)

## [v0.0.84](https://github.com/vghn/puppet/tree/v0.0.84) (2016-08-01)
[Full Changelog](https://github.com/vghn/puppet/compare/v0.0.83...v0.0.84)

## [v0.0.83](https://github.com/vghn/puppet/tree/v0.0.83) (2016-08-01)
[Full Changelog](https://github.com/vghn/puppet/compare/v0.0.82...v0.0.83)

## [v0.0.82](https://github.com/vghn/puppet/tree/v0.0.82) (2016-07-31)
[Full Changelog](https://github.com/vghn/puppet/compare/v0.0.81...v0.0.82)

## [v0.0.81](https://github.com/vghn/puppet/tree/v0.0.81) (2016-07-30)
[Full Changelog](https://github.com/vghn/puppet/compare/v0.0.80...v0.0.81)

## [v0.0.80](https://github.com/vghn/puppet/tree/v0.0.80) (2016-07-29)
[Full Changelog](https://github.com/vghn/puppet/compare/v0.0.79...v0.0.80)

## [v0.0.79](https://github.com/vghn/puppet/tree/v0.0.79) (2016-07-29)
[Full Changelog](https://github.com/vghn/puppet/compare/v0.0.78...v0.0.79)

## [v0.0.78](https://github.com/vghn/puppet/tree/v0.0.78) (2016-07-29)
[Full Changelog](https://github.com/vghn/puppet/compare/v0.0.77...v0.0.78)

## [v0.0.77](https://github.com/vghn/puppet/tree/v0.0.77) (2016-07-29)
[Full Changelog](https://github.com/vghn/puppet/compare/v0.0.76...v0.0.77)

## [v0.0.76](https://github.com/vghn/puppet/tree/v0.0.76) (2016-07-29)
[Full Changelog](https://github.com/vghn/puppet/compare/v0.0.75...v0.0.76)

## [v0.0.75](https://github.com/vghn/puppet/tree/v0.0.75) (2016-07-28)
[Full Changelog](https://github.com/vghn/puppet/compare/v0.0.74...v0.0.75)

## [v0.0.74](https://github.com/vghn/puppet/tree/v0.0.74) (2016-07-28)
[Full Changelog](https://github.com/vghn/puppet/compare/v0.0.73...v0.0.74)

## [v0.0.73](https://github.com/vghn/puppet/tree/v0.0.73) (2016-07-28)
[Full Changelog](https://github.com/vghn/puppet/compare/v0.0.72...v0.0.73)

## [v0.0.72](https://github.com/vghn/puppet/tree/v0.0.72) (2016-07-28)
[Full Changelog](https://github.com/vghn/puppet/compare/v0.0.71...v0.0.72)

## [v0.0.71](https://github.com/vghn/puppet/tree/v0.0.71) (2016-07-25)
[Full Changelog](https://github.com/vghn/puppet/compare/v0.0.70...v0.0.71)

## [v0.0.70](https://github.com/vghn/puppet/tree/v0.0.70) (2016-07-24)
[Full Changelog](https://github.com/vghn/puppet/compare/v0.0.69...v0.0.70)

## [v0.0.69](https://github.com/vghn/puppet/tree/v0.0.69) (2016-07-23)
[Full Changelog](https://github.com/vghn/puppet/compare/v0.0.68...v0.0.69)

## [v0.0.68](https://github.com/vghn/puppet/tree/v0.0.68) (2016-07-22)
[Full Changelog](https://github.com/vghn/puppet/compare/v0.0.67...v0.0.68)

## [v0.0.67](https://github.com/vghn/puppet/tree/v0.0.67) (2016-07-22)
[Full Changelog](https://github.com/vghn/puppet/compare/v0.0.66...v0.0.67)

## [v0.0.66](https://github.com/vghn/puppet/tree/v0.0.66) (2016-07-21)
[Full Changelog](https://github.com/vghn/puppet/compare/v0.0.65...v0.0.66)

## [v0.0.65](https://github.com/vghn/puppet/tree/v0.0.65) (2016-07-21)
[Full Changelog](https://github.com/vghn/puppet/compare/v0.0.64...v0.0.65)

## [v0.0.64](https://github.com/vghn/puppet/tree/v0.0.64) (2016-07-19)
[Full Changelog](https://github.com/vghn/puppet/compare/v0.0.63...v0.0.64)

**Implemented enhancements:**

- Add the VGS Library [\#21](https://github.com/vghn/puppet/issues/21)
- Use host local time inside containers [\#20](https://github.com/vghn/puppet/issues/20)

## [v0.0.63](https://github.com/vghn/puppet/tree/v0.0.63) (2016-06-30)
[Full Changelog](https://github.com/vghn/puppet/compare/v0.0.62...v0.0.63)

## [v0.0.62](https://github.com/vghn/puppet/tree/v0.0.62) (2016-06-30)
[Full Changelog](https://github.com/vghn/puppet/compare/v0.0.61...v0.0.62)

## [v0.0.61](https://github.com/vghn/puppet/tree/v0.0.61) (2016-06-30)
[Full Changelog](https://github.com/vghn/puppet/compare/v0.0.60...v0.0.61)

## [v0.0.60](https://github.com/vghn/puppet/tree/v0.0.60) (2016-06-30)
[Full Changelog](https://github.com/vghn/puppet/compare/v0.0.59...v0.0.60)

## [v0.0.59](https://github.com/vghn/puppet/tree/v0.0.59) (2016-06-27)
[Full Changelog](https://github.com/vghn/puppet/compare/v0.0.58...v0.0.59)

## [v0.0.58](https://github.com/vghn/puppet/tree/v0.0.58) (2016-06-26)
[Full Changelog](https://github.com/vghn/puppet/compare/v0.0.57...v0.0.58)

## [v0.0.57](https://github.com/vghn/puppet/tree/v0.0.57) (2016-06-26)
[Full Changelog](https://github.com/vghn/puppet/compare/v0.0.56...v0.0.57)

## [v0.0.56](https://github.com/vghn/puppet/tree/v0.0.56) (2016-06-25)
[Full Changelog](https://github.com/vghn/puppet/compare/v0.0.55...v0.0.56)

## [v0.0.55](https://github.com/vghn/puppet/tree/v0.0.55) (2016-06-25)
[Full Changelog](https://github.com/vghn/puppet/compare/v0.0.54...v0.0.55)

## [v0.0.54](https://github.com/vghn/puppet/tree/v0.0.54) (2016-06-25)
[Full Changelog](https://github.com/vghn/puppet/compare/v0.0.53...v0.0.54)

## [v0.0.53](https://github.com/vghn/puppet/tree/v0.0.53) (2016-06-25)
[Full Changelog](https://github.com/vghn/puppet/compare/v0.0.52...v0.0.53)

## [v0.0.52](https://github.com/vghn/puppet/tree/v0.0.52) (2016-06-25)
[Full Changelog](https://github.com/vghn/puppet/compare/v0.0.51...v0.0.52)

## [v0.0.51](https://github.com/vghn/puppet/tree/v0.0.51) (2016-06-24)
[Full Changelog](https://github.com/vghn/puppet/compare/v0.0.50...v0.0.51)

## [v0.0.50](https://github.com/vghn/puppet/tree/v0.0.50) (2016-06-22)
[Full Changelog](https://github.com/vghn/puppet/compare/v0.0.49...v0.0.50)

## [v0.0.49](https://github.com/vghn/puppet/tree/v0.0.49) (2016-06-10)
[Full Changelog](https://github.com/vghn/puppet/compare/v0.0.48...v0.0.49)

## [v0.0.48](https://github.com/vghn/puppet/tree/v0.0.48) (2016-06-09)
[Full Changelog](https://github.com/vghn/puppet/compare/v0.0.47...v0.0.48)

## [v0.0.47](https://github.com/vghn/puppet/tree/v0.0.47) (2016-06-09)
[Full Changelog](https://github.com/vghn/puppet/compare/v0.0.46...v0.0.47)

## [v0.0.46](https://github.com/vghn/puppet/tree/v0.0.46) (2016-06-08)
[Full Changelog](https://github.com/vghn/puppet/compare/v0.0.45...v0.0.46)

## [v0.0.45](https://github.com/vghn/puppet/tree/v0.0.45) (2016-06-08)
[Full Changelog](https://github.com/vghn/puppet/compare/v0.0.44...v0.0.45)

## [v0.0.44](https://github.com/vghn/puppet/tree/v0.0.44) (2016-06-08)
[Full Changelog](https://github.com/vghn/puppet/compare/v0.0.43...v0.0.44)

**Implemented enhancements:**

- Add vladgh/common module [\#19](https://github.com/vghn/puppet/issues/19)

## [v0.0.43](https://github.com/vghn/puppet/tree/v0.0.43) (2016-06-06)
[Full Changelog](https://github.com/vghn/puppet/compare/v0.0.42...v0.0.43)

## [v0.0.42](https://github.com/vghn/puppet/tree/v0.0.42) (2016-06-04)
[Full Changelog](https://github.com/vghn/puppet/compare/v0.0.41...v0.0.42)

## [v0.0.41](https://github.com/vghn/puppet/tree/v0.0.41) (2016-06-03)
[Full Changelog](https://github.com/vghn/puppet/compare/v0.0.40...v0.0.41)

## [v0.0.40](https://github.com/vghn/puppet/tree/v0.0.40) (2016-06-03)
[Full Changelog](https://github.com/vghn/puppet/compare/v0.0.39...v0.0.40)

## [v0.0.39](https://github.com/vghn/puppet/tree/v0.0.39) (2016-06-03)
[Full Changelog](https://github.com/vghn/puppet/compare/v0.0.38...v0.0.39)

## [v0.0.38](https://github.com/vghn/puppet/tree/v0.0.38) (2016-06-03)
[Full Changelog](https://github.com/vghn/puppet/compare/v0.0.37...v0.0.38)

## [v0.0.37](https://github.com/vghn/puppet/tree/v0.0.37) (2016-06-03)
[Full Changelog](https://github.com/vghn/puppet/compare/v0.0.36...v0.0.37)

## [v0.0.36](https://github.com/vghn/puppet/tree/v0.0.36) (2016-06-03)
[Full Changelog](https://github.com/vghn/puppet/compare/v0.0.35...v0.0.36)

## [v0.0.35](https://github.com/vghn/puppet/tree/v0.0.35) (2016-06-03)
[Full Changelog](https://github.com/vghn/puppet/compare/v0.0.34...v0.0.35)

## [v0.0.34](https://github.com/vghn/puppet/tree/v0.0.34) (2016-06-03)
[Full Changelog](https://github.com/vghn/puppet/compare/v0.0.33...v0.0.34)

## [v0.0.33](https://github.com/vghn/puppet/tree/v0.0.33) (2016-06-02)
[Full Changelog](https://github.com/vghn/puppet/compare/v0.0.32...v0.0.33)

## [v0.0.32](https://github.com/vghn/puppet/tree/v0.0.32) (2016-06-02)
[Full Changelog](https://github.com/vghn/puppet/compare/v0.0.31...v0.0.32)

## [v0.0.31](https://github.com/vghn/puppet/tree/v0.0.31) (2016-06-01)
[Full Changelog](https://github.com/vghn/puppet/compare/v0.0.30...v0.0.31)

## [v0.0.30](https://github.com/vghn/puppet/tree/v0.0.30) (2016-06-01)
[Full Changelog](https://github.com/vghn/puppet/compare/v0.0.29...v0.0.30)

## [v0.0.29](https://github.com/vghn/puppet/tree/v0.0.29) (2016-06-01)
[Full Changelog](https://github.com/vghn/puppet/compare/v0.0.28...v0.0.29)

## [v0.0.28](https://github.com/vghn/puppet/tree/v0.0.28) (2016-06-01)
[Full Changelog](https://github.com/vghn/puppet/compare/v0.0.27...v0.0.28)

## [v0.0.27](https://github.com/vghn/puppet/tree/v0.0.27) (2016-06-01)
[Full Changelog](https://github.com/vghn/puppet/compare/v0.0.26...v0.0.27)

## [v0.0.26](https://github.com/vghn/puppet/tree/v0.0.26) (2016-06-01)
[Full Changelog](https://github.com/vghn/puppet/compare/v0.0.25...v0.0.26)

## [v0.0.25](https://github.com/vghn/puppet/tree/v0.0.25) (2016-05-31)
[Full Changelog](https://github.com/vghn/puppet/compare/v0.0.24...v0.0.25)

## [v0.0.24](https://github.com/vghn/puppet/tree/v0.0.24) (2016-05-31)
[Full Changelog](https://github.com/vghn/puppet/compare/v0.0.23...v0.0.24)

## [v0.0.23](https://github.com/vghn/puppet/tree/v0.0.23) (2016-05-30)
[Full Changelog](https://github.com/vghn/puppet/compare/v0.0.22...v0.0.23)

**Fixed bugs:**

- Ensure a logical manifest order through out [\#18](https://github.com/vghn/puppet/issues/18)

## [v0.0.22](https://github.com/vghn/puppet/tree/v0.0.22) (2016-05-24)
[Full Changelog](https://github.com/vghn/puppet/compare/v0.0.21...v0.0.22)

**Fixed bugs:**

- Upgrade git [\#17](https://github.com/vghn/puppet/issues/17)

## [v0.0.21](https://github.com/vghn/puppet/tree/v0.0.21) (2016-05-21)
[Full Changelog](https://github.com/vghn/puppet/compare/v0.0.20...v0.0.21)

## [v0.0.20](https://github.com/vghn/puppet/tree/v0.0.20) (2016-05-20)
[Full Changelog](https://github.com/vghn/puppet/compare/v0.0.19...v0.0.20)

## [v0.0.19](https://github.com/vghn/puppet/tree/v0.0.19) (2016-05-19)
[Full Changelog](https://github.com/vghn/puppet/compare/0.0.18...v0.0.19)

## [0.0.18](https://github.com/vghn/puppet/tree/0.0.18) (2016-05-19)
[Full Changelog](https://github.com/vghn/puppet/compare/0.0.17...0.0.18)

## [0.0.17](https://github.com/vghn/puppet/tree/0.0.17) (2016-05-10)
[Full Changelog](https://github.com/vghn/puppet/compare/0.0.16...0.0.17)

## [0.0.16](https://github.com/vghn/puppet/tree/0.0.16) (2016-05-10)
[Full Changelog](https://github.com/vghn/puppet/compare/0.0.15...0.0.16)

## [0.0.15](https://github.com/vghn/puppet/tree/0.0.15) (2016-05-10)
[Full Changelog](https://github.com/vghn/puppet/compare/0.0.14...0.0.15)

## [0.0.14](https://github.com/vghn/puppet/tree/0.0.14) (2016-05-10)
[Full Changelog](https://github.com/vghn/puppet/compare/0.0.13...0.0.14)

## [0.0.13](https://github.com/vghn/puppet/tree/0.0.13) (2016-05-10)
[Full Changelog](https://github.com/vghn/puppet/compare/0.0.12...0.0.13)

## [0.0.12](https://github.com/vghn/puppet/tree/0.0.12) (2016-05-10)
[Full Changelog](https://github.com/vghn/puppet/compare/0.0.11...0.0.12)

## [0.0.11](https://github.com/vghn/puppet/tree/0.0.11) (2016-05-10)
[Full Changelog](https://github.com/vghn/puppet/compare/0.0.10...0.0.11)

## [0.0.10](https://github.com/vghn/puppet/tree/0.0.10) (2016-05-10)
[Full Changelog](https://github.com/vghn/puppet/compare/0.0.9...0.0.10)

## [0.0.9](https://github.com/vghn/puppet/tree/0.0.9) (2016-05-10)
[Full Changelog](https://github.com/vghn/puppet/compare/0.0.8...0.0.9)

## [0.0.8](https://github.com/vghn/puppet/tree/0.0.8) (2016-05-09)
[Full Changelog](https://github.com/vghn/puppet/compare/0.0.7...0.0.8)

## [0.0.7](https://github.com/vghn/puppet/tree/0.0.7) (2016-05-04)
[Full Changelog](https://github.com/vghn/puppet/compare/0.0.6...0.0.7)

## [0.0.6](https://github.com/vghn/puppet/tree/0.0.6) (2016-05-01)
[Full Changelog](https://github.com/vghn/puppet/compare/0.0.5...0.0.6)

## [0.0.5](https://github.com/vghn/puppet/tree/0.0.5) (2016-05-01)
[Full Changelog](https://github.com/vghn/puppet/compare/0.0.4...0.0.5)

## [0.0.4](https://github.com/vghn/puppet/tree/0.0.4) (2016-04-29)
[Full Changelog](https://github.com/vghn/puppet/compare/0.0.3...0.0.4)

## [0.0.3](https://github.com/vghn/puppet/tree/0.0.3) (2016-04-28)
[Full Changelog](https://github.com/vghn/puppet/compare/0.0.2...0.0.3)

## [0.0.2](https://github.com/vghn/puppet/tree/0.0.2) (2016-04-28)
[Full Changelog](https://github.com/vghn/puppet/compare/0.0.1...0.0.2)

## [0.0.1](https://github.com/vghn/puppet/tree/0.0.1) (2016-04-27)
**Implemented enhancements:**

- Test each AMI before it is created [\#16](https://github.com/vghn/puppet/issues/16)
- Do not encourage piping curl into sh [\#15](https://github.com/vghn/puppet/issues/15)

**Fixed bugs:**

- Generate a CSR Attributes file before installing Puppet [\#14](https://github.com/vghn/puppet/issues/14)

**Closed issues:**

- RuboCop [\#2](https://github.com/vghn/puppet/issues/2)

**Merged pull requests:**

- Launch [\#13](https://github.com/vghn/puppet/pull/13) ([vladgh](https://github.com/vladgh))
- Pre Launch [\#12](https://github.com/vghn/puppet/pull/12) ([vladgh](https://github.com/vladgh))
- Bootstrap [\#11](https://github.com/vghn/puppet/pull/11) ([vladgh](https://github.com/vladgh))
- More work [\#10](https://github.com/vghn/puppet/pull/10) ([vladgh](https://github.com/vladgh))
- More improvements [\#9](https://github.com/vghn/puppet/pull/9) ([vladgh](https://github.com/vladgh))
- More improvements [\#8](https://github.com/vghn/puppet/pull/8) ([vladgh](https://github.com/vladgh))
- Improvements [\#7](https://github.com/vghn/puppet/pull/7) ([vladgh](https://github.com/vladgh))
- Acceptance and unit testing [\#6](https://github.com/vghn/puppet/pull/6) ([vladgh](https://github.com/vladgh))
- Updates [\#5](https://github.com/vghn/puppet/pull/5) ([vladgh](https://github.com/vladgh))
- Enabe hiera lookups in tests [\#4](https://github.com/vghn/puppet/pull/4) ([vladgh](https://github.com/vladgh))
- Minor changes [\#3](https://github.com/vghn/puppet/pull/3) ([vladgh](https://github.com/vladgh))
- Add Tests [\#1](https://github.com/vghn/puppet/pull/1) ([vladgh](https://github.com/vladgh))



\* *This Change Log was automatically generated by [github_changelog_generator](https://github.com/skywinder/Github-Changelog-Generator)*