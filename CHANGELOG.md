## Version 0.0.98 / 2016-08-13
  * Add Slack slash command ([Vlad - 4768e33](https://github.com/vghn/puppet/commit/4768e3344dbbd016d1341cca5b46423c92c79085))

## Version 0.0.97 / 2016-08-13
  * Add logs to the MINI role ([Vlad - 0f5baff](https://github.com/vghn/puppet/commit/0f5baffc5f7c9721f7c74fc7d2f7e796dcaec241))
  * Add Samba to the MINI role ([Vlad - 575510f](https://github.com/vghn/puppet/commit/575510f5d282f387a98ec10b196c86fe4ec22a0b))

## Version 0.0.96 / 2016-08-12
  * Improve the bootstrap script ([Vlad - 2f00dcd](https://github.com/vghn/puppet/commit/2f00dcdccd432077c481ae85697279baa090ae2f))

## Version 0.0.95 / 2016-08-12
  * Allow specifying the SSL Certificate ([Vlad - 8053c8e](https://github.com/vghn/puppet/commit/8053c8e7361b6588f4f9c58627c841a300a5cd4e))

## Version 0.0.94 / 2016-08-12
  * Do not purge fail2ban firewall rules ([Vlad - f61f552](https://github.com/vghn/puppet/commit/f61f552beb4a352b79fdfd775a9d3806c0b78e05))

## Version 0.0.93 / 2016-08-12
  * Firewall should end by dropping input and forward ([Vlad - a3dc459](https://github.com/vghn/puppet/commit/a3dc45900cfd21428bc938f9ddb3f68b6b809500))
  * Fix testing modules fixture config ([Vlad - 42c040e](https://github.com/vghn/puppet/commit/42c040eedc028824e5093677251a36fa42d97a09))
  * Separate firewall from base profile ([Vlad - 10e8938](https://github.com/vghn/puppet/commit/10e89389dd96ac438a365857c54a7b69bede6da2))
  * Add fail2ban ([Vlad - 8d349ab](https://github.com/vghn/puppet/commit/8d349abc85e32d1b494ce5a697f32ab0ca33b4f1))
  * Purge firewall rules (with exceptions) ([Vlad - 5fea6bb](https://github.com/vghn/puppet/commit/5fea6bb83aac8b44e3572a687bc2a9784f9a3bdf))
  * Fix tests ([Vlad - ffca18b](https://github.com/vghn/puppet/commit/ffca18b6ca819c09e7bacd1e2233e243f196dfc7))

## Version 0.0.92 / 2016-08-12
  * Fix environment paths ([Vlad - c6c48de](https://github.com/vghn/puppet/commit/c6c48de82514bdc4761ba3cf4d9a8e8fbef164ff))
  * Check bootstrap invovation ([Vlad - 7955db4](https://github.com/vghn/puppet/commit/7955db448c876657fec8727d42053fed09385adf))
  * Firewall should not purge other chains ([Vlad - df14d67](https://github.com/vghn/puppet/commit/df14d67c9c0ba5aa1ceda90cf88b7e4bc314f0c2))
  * Improve firewall rules ([Vlad - 38d71d1](https://github.com/vghn/puppet/commit/38d71d1b4329b2e9525054e3bc14c0b69a489ba1))
  * Fix unit tests ([Vlad - 5f5fe31](https://github.com/vghn/puppet/commit/5f5fe31e5068157dcc8b4efadcc905bb217d26e3))

## Version 0.0.91 / 2016-08-11
  * Use relative paths in gitignore ([Vlad - 5e14dd0](https://github.com/vghn/puppet/commit/5e14dd0cabfc19a4590971b205423724db7c5d25))
  * Add Sinatra WebHook to the data container ([Vlad - 2a71583](https://github.com/vghn/puppet/commit/2a715834bc8499bb73ab3147caf457e4bb02e361))
  * Verify Github signatures for the webhook ([Vlad - 4748c46](https://github.com/vghn/puppet/commit/4748c46de8e47e2c23a69ea70f274b9455b970dd))

## Version 0.0.90 / 2016-08-10
  * Update Readme ([Vlad - 9b34142](https://github.com/vghn/puppet/commit/9b341424e3dd092c508af40d661c16326b4ef458))
  * Upgrade APT module to master branch ([Vlad - b5f4d52](https://github.com/vghn/puppet/commit/b5f4d521d70a027b9fc41d8b67897f828f2020f0))
  * Clean-up ([Vlad - 8016cc4](https://github.com/vghn/puppet/commit/8016cc4d1c460c27b2e606e439f0721f5df4ddff))
  * Add firewall ([Vlad - e54bfa7](https://github.com/vghn/puppet/commit/e54bfa713d3b813f5a69d92821b822285cf00f5f))
  * Upgrade production to 1G memory ([Vlad - 9ee8039](https://github.com/vghn/puppet/commit/9ee80393bff3c89a0eab8a273872bab2f9215050))
  * Use full hostname for Puppet Server container ([Vlad - 5b63134](https://github.com/vghn/puppet/commit/5b6313429c1ccf58bfa05bd370d9b3a7844fe5a6))
  * Fix deployment ([Vlad - 16ec408](https://github.com/vghn/puppet/commit/16ec408506558437ba51b8892a53f41f4e313e93))
  * Override VERSION ([Vlad - e212e17](https://github.com/vghn/puppet/commit/e212e1772f6f9f0e96f88339883f5d04a5344b24))
  * Fix deployment script ([Vlad - 4e7921a](https://github.com/vghn/puppet/commit/4e7921ac705af78985956b4b48bd5cf53f8741a3))

## Version 0.0.89 / 2016-08-09
  * Move Puppet/Archive to approved modules ([Vlad - 9c15bb5](https://github.com/vghn/puppet/commit/9c15bb5bfaecec9b8902a6cbe33ad7ddbb2763c7))
  * Fix typos ([Vlad - 4615411](https://github.com/vghn/puppet/commit/4615411c9a4758611fbdfddea3ca129b1dc1cc74))
  * Hiera should use environments ([Vlad - 3234ac6](https://github.com/vghn/puppet/commit/3234ac62986cfb2811a6bd0b88712fca3f965a1c))
  * Add Samba class to Mini role ([Vlad - e2ccf5b](https://github.com/vghn/puppet/commit/e2ccf5b82830a7e8598b0140126cdf69d7e6b2b0))
  * Autosign script should read environment config ([Vlad - 00265ea](https://github.com/vghn/puppet/commit/00265eaea2170713bd0de5bbd17b1b7dd5e760b1))
  * Upgrade saz/rsyslog puppet module ([Vlad - 7f487b3](https://github.com/vghn/puppet/commit/7f487b3633a5489ecd10e093de7061c8f7c5e184))
  * The Puppet Server container hostname should be puppet ([Vlad - 249b1d0](https://github.com/vghn/puppet/commit/249b1d0f49e7863636fc9cd5b0872d1ec63ff0f6))
  * Upgrade software ([Vlad - 9b0e7c5](https://github.com/vghn/puppet/commit/9b0e7c5888e31b57099db3279cbd8cb04119ec2a))

## Version 0.0.88 / 2016-08-04
  * Update Readme ([Vlad - f4e75e1](https://github.com/vghn/puppet/commit/f4e75e12c48eced9dcaaef6231e952c90e50fc44))
  * Improve Puppet Server health check url ([Vlad - 12e4671](https://github.com/vghn/puppet/commit/12e4671d8ae4553e56f3fb44c173f80c9b3ea937))
  * Include the wget class ([Vlad - 2b199d2](https://github.com/vghn/puppet/commit/2b199d21a56fff00574943421d07535ea97e4515))

## Version 0.0.87 / 2016-08-03
  * Add README for Docker images ([Vlad - 506b296](https://github.com/vghn/puppet/commit/506b296c9fdf6f4613739a5c7bf82b19c11e1cbb))
  * Do not daemonize data container when pushing changes ([Vlad - c270a0c](https://github.com/vghn/puppet/commit/c270a0ce0aca41132a560dc4a10052b1fe28119c))
  * Add a healthcheck for the server container ([Vlad - f93c648](https://github.com/vghn/puppet/commit/f93c6487e6bb66bada4646ff69fffc7d813911f2))
  * Update docker in CI server ([Vlad - c937c48](https://github.com/vghn/puppet/commit/c937c48252a5ca9028b15b3f7c8f083f0bd39be0))
  * Do not modify docker's config file when updating ([Vlad - 7f0c15d](https://github.com/vghn/puppet/commit/7f0c15d49687cc2a9330cae5d48a12c54c73a81b))
  * Only run spec test in CI for dockerfiles ([Vlad - 6b41a33](https://github.com/vghn/puppet/commit/6b41a33e29c2de7c117d1370466886a86c86be46))
  * Update aws-sdk gem ([Vlad - ab641a2](https://github.com/vghn/puppet/commit/ab641a2c10d9a8ab4115bf0aff903fbb87c80e61))

## Version 0.0.86 / 2016-08-02
  * Use expect in tests ([Vlad - 4a3aa89](https://github.com/vghn/puppet/commit/4a3aa8916da73dbc8776de29f9861f0d6dbee0b1))
  * Rename spec shared example files ([Vlad - d726fff](https://github.com/vghn/puppet/commit/d726fff71c71cadee7616927b8ecc0913d614aa1))
  * Test using Ubuntu 16.04 Puppet vagrant image ([Vlad - bb5cef1](https://github.com/vghn/puppet/commit/bb5cef1ec7dbe394000b3138b59ef5a2f3ee11b9))
  * Add Ubuntu 16.04 to supported systems ([Vlad - d040558](https://github.com/vghn/puppet/commit/d040558bb8e4a5fce349c30dd3efc7aa85e42628))

## Version 0.0.85 / 2016-08-01
  * Spec docker images ([Vlad - 2673b26](https://github.com/vghn/puppet/commit/2673b267989a375288b31af075ec3d315834364d))
  * Add tests for docker images ([Vlad - 644c383](https://github.com/vghn/puppet/commit/644c3835bafa0451657d09ef4e07dd234ecd5184))
  * Fix typo ([Vlad - cd07c3a](https://github.com/vghn/puppet/commit/cd07c3a4772ac2d9d6e86fdb0cd7f681b586571b))
  * Improve puppet server image tests ([Vlad - 0191bd1](https://github.com/vghn/puppet/commit/0191bd1ddc1c9c6e830ef35216368ff9b72fdf96))
  * Fix spec tests ([Vlad - b5c8904](https://github.com/vghn/puppet/commit/b5c89047b687e39953608b9b1cd9f7121ca545fd))
  * Fix spec tests ([Vlad - 9bae2f4](https://github.com/vghn/puppet/commit/9bae2f481ceb998a7273e914a2a6dad3bb874b52))
  * Improve tests ([Vlad - 1764b5c](https://github.com/vghn/puppet/commit/1764b5c25c13dea20de731dc95b0923de38a3e94))
  * Wait for services to start before testing ([Vlad - 7e54935](https://github.com/vghn/puppet/commit/7e54935dbce7d40d6db966a68617f6f438de6dab))
  * Revert version ([Vlad - 8f6a4e7](https://github.com/vghn/puppet/commit/8f6a4e7b0095f8f09193f3781fb159f069c10a6c))

## Version 0.0.84 / 2016-08-01
  * Only deploy data for now ([Vlad - 2e1b455](https://github.com/vghn/puppet/commit/2e1b455c2acfdb8c0cc70fe1fb300aa47b29e649))

## Version 0.0.83 / 2016-07-31
  * Fix start script ([Vlad - 89c166e](https://github.com/vghn/puppet/commit/89c166e8694f3f8d6ab2064e60f83c0b3e679878))
  * Fix SSM command ([Vlad - 6b19dfc](https://github.com/vghn/puppet/commit/6b19dfccb193ae380d89e22044cef91d86238784))

## Version 0.0.82 / 2016-07-31
  * Do not lint Dockerfile in the CI ([Vlad - ae8b68d](https://github.com/vghn/puppet/commit/ae8b68db6633b44273a460e2259f4aa69ae2a3c8))
  * Improve docker environment ([Vlad - 8932b17](https://github.com/vghn/puppet/commit/8932b173ed3dfeaffeeea95ed0c7faf50d6c9067))
  * Fix CI build script ([Vlad - 0626fad](https://github.com/vghn/puppet/commit/0626fada3502dfb803ba2975cb21d4920b2c39e1))

## Version 0.0.81 / 2016-07-30
  * Use the environment detection from the VGS Library ([Vlad - b1d354d](https://github.com/vghn/puppet/commit/b1d354d3205fbdbd4a430c39c508bf3276b38db3))
  * Add fail safe for the environment ([Vlad - 3cf487b](https://github.com/vghn/puppet/commit/3cf487b7dbefb2763d333eaf32648f33402f3563))
  * Clean-up functions ([Vlad - 3d43aae](https://github.com/vghn/puppet/commit/3d43aaef67057047a99aa4c099b938854067b49f))
  * Fix bootstrap script for masterless setup ([Vlad - b476f19](https://github.com/vghn/puppet/commit/b476f193fa156f26e1f2371f41f89f5afa4f887e))
  * Add pull data command ([Vlad - 246242b](https://github.com/vghn/puppet/commit/246242b87707d156f185dfece476f7507b7aecda))
  * Improve docker compose environment ([Vlad - 72e3052](https://github.com/vghn/puppet/commit/72e3052ee6827d143034d9356fead5a23c81e85d))

## Version 0.0.80 / 2016-07-29
  * Unload RVM in order to use the gems installed by Puppet ([Vlad - 495a784](https://github.com/vghn/puppet/commit/495a784b17fd0d2aa320a12c38d5502f11fa68b0))

## Version 0.0.79 / 2016-07-29
  * Update everything before restarting ([Vlad - 4b9d48b](https://github.com/vghn/puppet/commit/4b9d48b0f3f7b98b69e32acb458ed9317dc438bc))

## Version 0.0.78 / 2016-07-29
  * The start script should update the repo first ([Vlad - 6e2a2ef](https://github.com/vghn/puppet/commit/6e2a2ef8fa69ca4a3769119deb2d0f833c680fd3))

## Version 0.0.77 / 2016-07-29
  * Download data when starting containers ([Vlad - 71d5795](https://github.com/vghn/puppet/commit/71d5795f0a6ceb38e9f9f88a0b781ac325726b9d))

## Version 0.0.76 / 2016-07-29
  * Add a Vagrantfile ([Vlad - 80f3857](https://github.com/vghn/puppet/commit/80f38570bec3481fb09531e36b05a5769b651bbe))
  * Clean-up start script docker compose files ([Vlad - 5c7ceb0](https://github.com/vghn/puppet/commit/5c7ceb067d559cece08ff668560201d5a4fedaff))
  * Upgrade docker-compose and docker-machine ([Vlad - f81ee14](https://github.com/vghn/puppet/commit/f81ee1434b55a1ad47b78c7d55b0f06cfc48a3e4))
  * Add puppet apply option in the bootstrap script ([Vlad - c005436](https://github.com/vghn/puppet/commit/c00543600ac58e8beecbbc47334ce9bf192fe25f))

## Version 0.0.75 / 2016-07-28
  * Fix aws sync functions ([Vlad - ed3cd39](https://github.com/vghn/puppet/commit/ed3cd3926af8a3577526545f7eeec9e512e1f187))
  * Improve exit code processing in bootstrap ([Vlad - b800532](https://github.com/vghn/puppet/commit/b80053200c1dc343b8aa7119ed7a950083c66444))

## Version 0.0.74 / 2016-07-28
  * Allow starting a local master and rename image folder ([Vlad - f71ace1](https://github.com/vghn/puppet/commit/f71ace1c23cea890eee2a148ea0e6aa703dd3fd7))

## Version 0.0.73 / 2016-07-28
  * Login to docker registry before pushing ([Vlad - f869d2d](https://github.com/vghn/puppet/commit/f869d2d417d5fef822b2f9430186f7305dc6fbc8))

## Version 0.0.72 / 2016-07-28
  * Improve update workflow ([Vlad - 205f601](https://github.com/vghn/puppet/commit/205f601430b70c119abc0d45e621f58f77ea7077))
  * Improve docker compose environment ([Vlad - bc25c7b](https://github.com/vghn/puppet/commit/bc25c7b9c0ae7d4dcf8ccf786c4febb946aa9fcf))
  * Add command to show the docker compose logs ([Vlad - 5f73f0f](https://github.com/vghn/puppet/commit/5f73f0f3399337d2888c9a3121dce3c86bd2cee5))
  * Move `bootstrap` script to `bin/bootstrap` ([Vlad - 73ff8ed](https://github.com/vghn/puppet/commit/73ff8edbc8c00ab6dd05092c5a304a28ba52cac8))
  * Create custom docker images (tested and built by the CI) ([Vlad - 8e29a8f](https://github.com/vghn/puppet/commit/8e29a8f5b41a12aebb2fbd9a983cf853264eebc5))
  * Publish artifact after successful build ([Vlad - c2d53f3](https://github.com/vghn/puppet/commit/c2d53f3d9a45b30dd105e248900f74d36861a2f7))
  * Retrieve S3 data ([Vlad - f0da1f0](https://github.com/vghn/puppet/commit/f0da1f0fb179442c83fb4468f39ff5b0435bc932))
  * Better travis cache ([Vlad - 9ccbdc4](https://github.com/vghn/puppet/commit/9ccbdc49607d08306d509ee85453c6efc764bd19))
  * Only configure puppet if agent will run ([Vlad - 34090cd](https://github.com/vghn/puppet/commit/34090cd210990a9e843fb152eba06fbaf106dd4e))
  * Allow server container to toggle data wait ([Vlad - 4c0f8d7](https://github.com/vghn/puppet/commit/4c0f8d79802d94b1376b4bd6ead8002d28303d55))
  * Fix Travis cache ([Vlad - c12304f](https://github.com/vghn/puppet/commit/c12304fd2a5fa121ecac773b72fb3603f32bbadc))

## Version 0.0.71 / 2016-07-25
  * Enable bash strict mode for the bootstrap script ([Vlad - f0c4155](https://github.com/vghn/puppet/commit/f0c4155b97dfa4d99ff3252d05415421214a8118))
  * Install lsb-release command during bootstrap ([Vlad - b0a3c5d](https://github.com/vghn/puppet/commit/b0a3c5de6223310f609a164f9b1d9027178ce85e))
  * Puppet module updates ([Vlad - 3218e30](https://github.com/vghn/puppet/commit/3218e302fdffdeade6dd5956e76f6577e5748644))

## Version 0.0.70 / 2016-07-24
  * Add more modules and clean-up environment ([Vlad - 158db3a](https://github.com/vghn/puppet/commit/158db3a92c4c12e1c8d34866ebd0d29186326e47))
  * Improve the sensitive data workflow ([Vlad - 4667cac](https://github.com/vghn/puppet/commit/4667cac5c521fa6ee300f110f872182dfcbb51d1))

## Version 0.0.69 / 2016-07-22
  * Add default for the data-only parameter of run ([Vlad - 142a7cb](https://github.com/vghn/puppet/commit/142a7cb48417a2b510e85597dfa76c74b6570075))

## Version 0.0.68 / 2016-07-22
  * Add a data-only option to the run script ([Vlad - 8b6dcd7](https://github.com/vghn/puppet/commit/8b6dcd773bde40db8dbeba04adea76311c659758))
  * Do not purge sudo configuration ([Vlad - 45f03f1](https://github.com/vghn/puppet/commit/45f03f130d74a1cbf3e1617cd8f87b163c309262))

## Version 0.0.67 / 2016-07-22
  * Create script for CI to upload artifacts to S3 ([Vlad - 47adcc3](https://github.com/vghn/puppet/commit/47adcc34dd74ee90f9fb4c776c239e31a8786a24))
  * Add saz/sudo puppet module ([Vlad - ad3f978](https://github.com/vghn/puppet/commit/ad3f978a6e98a7cb28cbd4c6b3ef8019308935b1))
  * Clean-up roles ([Vlad - 75ac98f](https://github.com/vghn/puppet/commit/75ac98f474c9036689f10941c8290d6d2e72874e))

## Version 0.0.66 / 2016-07-21
  * Fix production docker compose file ([Vlad - 996f7e0](https://github.com/vghn/puppet/commit/996f7e0a708bd6d9423c6d1532527063ab84f85f))

## Version 0.0.65 / 2016-07-21
  * Fix typo ([Vlad - a721829](https://github.com/vghn/puppet/commit/a7218293a3098d28033e77143d7c5719cf3d84cf))
  * Fix ssl sync agent hostname ([Vlad - b21bf53](https://github.com/vghn/puppet/commit/b21bf53e02105cb5ce2b928d01d3efae9f9b822b))
  * Add AWS EFS profile ([Vlad - 5df9716](https://github.com/vghn/puppet/commit/5df9716c1b609a4cce35d44607c554c36a239531))
  * Create a separate .env file for the logging agent ([Vlad - 52456ea](https://github.com/vghn/puppet/commit/52456ea19ad9ad57d2f9ff94af248dfba0087796))
  * Separate .env file ([Vlad - 598d4f8](https://github.com/vghn/puppet/commit/598d4f8021531f4a7ebe3b23205d7c0a81c4fb65))
  * Get variables from the private data container ([Vlad - 7d7d5e2](https://github.com/vghn/puppet/commit/7d7d5e20280c382c6ec480cae9b8031f967a3233))
  * The CloudFormation profile should not handle the service ([Vlad - e30f7b1](https://github.com/vghn/puppet/commit/e30f7b123dd71eea280fda2818f9a95328fd8e16))
  * Improve Puppet Master start script ([Vlad - 959f17b](https://github.com/vghn/puppet/commit/959f17be5b2adb564ac4b7b12f2f34aebce7da54))
  * Overwrite the version number ([Vlad - 2fa94df](https://github.com/vghn/puppet/commit/2fa94df3de11bad156a497fe887e0d7e0bbbf036))

## Version 0.0.64 / 2016-07-19
  * Fix project path ([Vlad - ced4aee](https://github.com/vghn/puppet/commit/ced4aee2b5d88b33696c595a0d69998607d5bbc7))
  * Improve CloudFormation helper scripts ([Vlad - 9b0054c](https://github.com/vghn/puppet/commit/9b0054c2a779f4660a3cad806971ac2abf45c519))
  * Fix CloudFormation helper init script mode ([Vlad - 3bdde2a](https://github.com/vghn/puppet/commit/3bdde2acaaecc122c0599ad54fce3f4392417c8b))
  * Add new PP_APPLICATION extension ([Vlad - 1017760](https://github.com/vghn/puppet/commit/1017760dde4a6511233372e2d6e07e07ffdd7dc2))
  * Separate essential packages ([Vlad - a9cc251](https://github.com/vghn/puppet/commit/a9cc25196028179593399aafaf00d1b8c7453979))
  * Add host local time to containers ([Vlad - 69d3a0f](https://github.com/vghn/puppet/commit/69d3a0f2812857512310997c30a5c320056aabbc))
  * Puppet module updates ([Vlad - 823eec1](https://github.com/vghn/puppet/commit/823eec163fff419b434478a886bd6c6b57523d65))
  * Improve bootstrap output ([Vlad - 2a3ff68](https://github.com/vghn/puppet/commit/2a3ff6814e1e0d7d4fdc78e3cc287f614372aebf))
  * Separate python from the base class ([Vlad - f2095c4](https://github.com/vghn/puppet/commit/f2095c4f87a86abf7a45d9f1aaf1ff49fba546ca))
  * Only include the apt class on Debian systems ([Vlad - ba0d0c5](https://github.com/vghn/puppet/commit/ba0d0c5833929e41611f159c5e8c45e6886bc0d3))
  * Improve Rhea upstart script ([Vlad - d3bd6a6](https://github.com/vghn/puppet/commit/d3bd6a6449750903e96e8b5b54ddddfbbd1c1263))
  * Minor updates ([Vlad - 62e2bf0](https://github.com/vghn/puppet/commit/62e2bf00e6462e9b171b0a3d7af83200b9f6f6ea))
  * Add RVM to RHEA ([Vlad - d603eea](https://github.com/vghn/puppet/commit/d603eea709d43f600f3068091b275e2f46f3e14f))
  * Add Ruby class ([Vlad - 608ed36](https://github.com/vghn/puppet/commit/608ed36e80f085f9829ffcb3c36a583ca1cc3126))
  * Be more specific with system ruby version ([Vlad - db4aa23](https://github.com/vghn/puppet/commit/db4aa236b72cd2d6664316f7285981bd189d837c))
  * Add the VGS Library ([Vlad - 269620e](https://github.com/vghn/puppet/commit/269620e38c4e62c65f12a1c50b9135ee6cbb0ece))
  * Improve bootstrap output ([Vlad - 1b1fe45](https://github.com/vghn/puppet/commit/1b1fe45b477b2771f09e1b6ecd94f084720c2e5b))
  * Update bundler ([Vlad - 6ea6e72](https://github.com/vghn/puppet/commit/6ea6e721d25b1e0d1a48509039f3e9440186dd0a))
  * Update bundler ([Vlad - a53477e](https://github.com/vghn/puppet/commit/a53477eb6e4bcac59fbaccc6a29bf249eb84cbde))
  * Fix typo ([Vlad - f8618af](https://github.com/vghn/puppet/commit/f8618af040c8eaf25eedac5923cf4033de5a86eb))
  * Add container to sync Puppet SSL keys ([Vlad - 9527fbc](https://github.com/vghn/puppet/commit/9527fbc81d1e0824ee087e39945f24433791e4d7))

## Version 0.0.63 / 2016-06-30
  * Fix path ([Vlad - db381ed](https://github.com/vghn/puppet/commit/db381ed9d6d896f57f77ef48f088023c628ef247))

## Version 0.0.62 / 2016-06-30
  * Fix environment ([Vlad - 7f29257](https://github.com/vghn/puppet/commit/7f292577062f546d5ec28c179230e38070273b8d))

## Version 0.0.61 / 2016-06-30
  * Improve output of the CSR sign script ([Vlad - ab27f7d](https://github.com/vghn/puppet/commit/ab27f7dfa679d378389f6b8d895e366a430fc5b5))
  * Fix environment ([Vlad - 18b6089](https://github.com/vghn/puppet/commit/18b60893c261637e3ce803d76bb6dbc63eb4f265))

## Version 0.0.60 / 2016-06-30
  * Update modules ([Vlad - 3b627bf](https://github.com/vghn/puppet/commit/3b627bfdf9cffaa3a9bb6b2c3f42675034b22b0e))
  * Change puppet path ([Vlad - d9ff85f](https://github.com/vghn/puppet/commit/d9ff85fe60349ab3bd89a23a4d3d758b0a5d49fd))

## Version 0.0.59 / 2016-06-27
  * Cron jobs are now in the VG module ([Vlad - 3305c20](https://github.com/vghn/puppet/commit/3305c20586b2b79559575c7e7d44a74828c9e2d9))
  * Separate logging profile ([Vlad - 219d20c](https://github.com/vghn/puppet/commit/219d20c84bd10ee03314228469ce3409d5ef8f96))

## Version 0.0.58 / 2016-06-26
  * Add rake tasks for the entire repo ([Vlad - 17fb63f](https://github.com/vghn/puppet/commit/17fb63f71b9a5d0553d3cbd7b5556e317028841a))
  * Add task to check for outdated forge modules ([Vlad - dfb62f6](https://github.com/vghn/puppet/commit/dfb62f66d5e9545dce2b913187836467c541406c))
  * Update ssh module ([Vlad - 71abad7](https://github.com/vghn/puppet/commit/71abad7768d2fbbadead916de991a7cf51c31985))

## Version 0.0.57 / 2016-06-26
  * Add timezone ([Vlad - 64b17ec](https://github.com/vghn/puppet/commit/64b17ecac62d571b111b273abc9c02c411017eed))

## Version 0.0.56 / 2016-06-25
  * Improve backup script ([Vlad - 33b81c8](https://github.com/vghn/puppet/commit/33b81c896148f1c65f1db45542b465d862858f26))

## Version 0.0.55 / 2016-06-25
  * Make puppet runs verbose ([Vlad - ca488b4](https://github.com/vghn/puppet/commit/ca488b45c7939e5311c3305f77942073d82473a5))
  * Fix backup scripts ([Vlad - 7a3f4d7](https://github.com/vghn/puppet/commit/7a3f4d714d438deb85ca39507d2acbcbc04f9285))

## Version 0.0.54 / 2016-06-25
  * Improve output of pre-commit hook ([Vlad - 5dcb78b](https://github.com/vghn/puppet/commit/5dcb78b32eb24769b336536dd33cf91b1dad1f04))
  * Add test for Puppetfile syntax ([Vlad - 2cc5530](https://github.com/vghn/puppet/commit/2cc553047189829a588d80551564dd9f5253d4df))
  * Add backup cron job ([Vlad - df8d5e3](https://github.com/vghn/puppet/commit/df8d5e3bbde48a036aae3e2e19998ecf67b9e4e2))

## Version 0.0.53 / 2016-06-25
  * Fix Rhea upstart script source ([Vlad - aa61bf2](https://github.com/vghn/puppet/commit/aa61bf2c27c1e5cfebb3e1bd88da66b804fd2f11))
  * Fix pre-commit checks ([Vlad - 074434a](https://github.com/vghn/puppet/commit/074434a31f294dfeade691b9b8703cb3743e1146))

## Version 0.0.52 / 2016-06-25
  * Fix puppet modules ([Vlad - 8edc633](https://github.com/vghn/puppet/commit/8edc633339a3e4556c98112867194ca84eec0661))
  * Update pre-commit hook ([Vlad - df71267](https://github.com/vghn/puppet/commit/df71267704f01661af5667f4c4a662e7ebd7c7f6))
  * Improve Gemfile and Rakefile ([Vlad - 796c363](https://github.com/vghn/puppet/commit/796c3634f1f152adf573bbb2e78fa3adda4e1030))
  * Separate run and update commands ([Vlad - 9a71032](https://github.com/vghn/puppet/commit/9a710328cc98af2b842c509b1ed5707c3dc0f7f3))
  * Improve run/update scripts ([Vlad - e2dcd27](https://github.com/vghn/puppet/commit/e2dcd27accb63698cb01e6c31358df69b6c42a8d))
  * Add Rhea upstart script ([Vlad - 323b978](https://github.com/vghn/puppet/commit/323b9785aeb93a26ef0b2cf587c3089e2ce8fc1e))
  * Add warning on files managed by Puppet ([Vlad - cd796d3](https://github.com/vghn/puppet/commit/cd796d39f1f3ea71a39c99ae8f743ade9bc4acd1))

## Version 0.0.51 / 2016-06-24
  * Add a data container and improve run scripts ([Vlad - 7768aa7](https://github.com/vghn/puppet/commit/7768aa713e9d888d93519bb97e3a6a6cc485ec17))

## Version 0.0.50 / 2016-06-22
  * Update Modules and gem ([Vlad - 01e16df](https://github.com/vghn/puppet/commit/01e16dfc8e62c72f4542c0a050eb39b5e3720958))
  * Fix EC2 SSM command ([Vlad - 604cdfe](https://github.com/vghn/puppet/commit/604cdfea367dbee69754b9ebcee9bb82779bb71f))
  * Fix Rhea start script ([Vlad - c65760e](https://github.com/vghn/puppet/commit/c65760e153cd0b2d6b602cb80e2108e698e3fe3c))
  * Create backup script ([Vlad - 7c0c95b](https://github.com/vghn/puppet/commit/7c0c95b3c1206a0745b80640dc695ccadeafab3d))
  * Puppet modules update ([Vlad - 71d959a](https://github.com/vghn/puppet/commit/71d959ab364504b06dd4f31732e9ff0e23873727))
  * Clean-up Rakefile and rename tests folder ([Vlad - 1be6217](https://github.com/vghn/puppet/commit/1be62174bb0114264304313845c8bb6b234b8b4e))
  * Fix main manifest ([Vlad - c15df87](https://github.com/vghn/puppet/commit/c15df87d9bbddc1656b75e0efcd46ccacc32e100))
  * Remove 3rd party lint checks ([Vlad - 7e8e13b](https://github.com/vghn/puppet/commit/7e8e13bbb0ff3d2ead59fe174991e9503333616e))
  * Add DNS alt names for the Puppet Master ([Vlad - 82705a4](https://github.com/vghn/puppet/commit/82705a427c7347a7cfe933a7cb158fe26f9188ae))
  * Set working directory ([Vlad - c04c3ef](https://github.com/vghn/puppet/commit/c04c3ef1a4f8771f2c01acfe7102c303b3553fcc))
  * Do not run if the directory is not right ([Vlad - 28045c7](https://github.com/vghn/puppet/commit/28045c78499a9cac35a5cbcd312ffc6b87daef8a))
  * Update README ([Vlad - 131ac78](https://github.com/vghn/puppet/commit/131ac78ea38e1b14d8eb4896c50d5d61284340d4))
  * Improve development environment ([Vlad - 9412249](https://github.com/vghn/puppet/commit/941224970fb627e15e9b83af4d6729f167adf329))
  * Clean-up ([Vlad - fef55d1](https://github.com/vghn/puppet/commit/fef55d1c0d647bf49d974db0bf805c78fc0635a7))
  * Improve run script ([Vlad - d07f58a](https://github.com/vghn/puppet/commit/d07f58a3b125e5b13f24ec51afce2a1c79b1d012))

## Version 0.0.49 / 2016-06-10
  * Fix policy based autosign script ([Vlad - 8efd856](https://github.com/vghn/puppet/commit/8efd85669826a818d4629089a5735b52da74c22a))
  * Fix Docker Compose Environment ([Vlad - 6b6f250](https://github.com/vghn/puppet/commit/6b6f250c4a7574508b6feadfdd465716ce3e93ad))

## Version 0.0.48 / 2016-06-09
  * Fix CSR autosign script ([Vlad - 1693e76](https://github.com/vghn/puppet/commit/1693e7601c9d13316c87670b5e18681408e383df))
  * Rename and improve MoM start script ([Vlad - e875aac](https://github.com/vghn/puppet/commit/e875aac0a7c0984fda25358345a3d0b0a4bd130a))
  * Add a separate data container ([Vlad - 5f7dd24](https://github.com/vghn/puppet/commit/5f7dd24bac9173ae40c752fd3ba501cdc7617f19))
  * Add warning if the role fact is not found ([Vlad - 2265abd](https://github.com/vghn/puppet/commit/2265abdf8f985dd04a811aab2fdaff132b04e6ed))
  * Improve Docker Compose ([Vlad - ab55248](https://github.com/vghn/puppet/commit/ab55248c898b89f289cdde32484c56d75f68d7d5))
  * Add bootstrap option to run puppet agent or not ([Vlad - fb91445](https://github.com/vghn/puppet/commit/fb9144597a4d4a79cce7b433b3cf1e6fdddee344))

## Version 0.0.47 / 2016-06-09
  * Fix bootstrap script ([Vlad - 73d85b3](https://github.com/vghn/puppet/commit/73d85b33bd0a9c909711c4f2c5d03af8960f021d))

## Version 0.0.46 / 2016-06-08
  * Improve container run scripts ([Vlad - 07ad22f](https://github.com/vghn/puppet/commit/07ad22f8459e930d56ec22eb8add25d2ae8284e5))
  * Simplify the bootstrap script ([Vlad - d32c193](https://github.com/vghn/puppet/commit/d32c1931c0f8d50e44ddfea469db779b32e275a9))
  * Add script to bootstrap Puppet Master of Masters ([Vlad - b511941](https://github.com/vghn/puppet/commit/b511941d28b502c97924077d4815a8ba5c608c5f))

## Version 0.0.45 / 2016-06-08
  * Add wait_for_data function ([Vlad - 841e23b](https://github.com/vghn/puppet/commit/841e23b5c3ea8ae6a0ccc98f8606edf1c54e80a4))
  * Append date to the deployment status file ([Vlad - d45de56](https://github.com/vghn/puppet/commit/d45de5630c0067df278df44ea39164f9a34263d0))
  * Improve environment declaration ([Vlad - 7466d04](https://github.com/vghn/puppet/commit/7466d048e0ae0918e65752795db510cd2bfc606b))

## Version 0.0.44 / 2016-06-08
  * Move sensitive data to 'private/' ([Vlad - 9098993](https://github.com/vghn/puppet/commit/9098993430acddc63d1244cb250da18ac939d713))
  * Improve environment detection ([Vlad - 256e1f9](https://github.com/vghn/puppet/commit/256e1f942607decb5ecae808061b5b2b2e717f18))
  * Separate upload of hiera and private data ([Vlad - 3b6df64](https://github.com/vghn/puppet/commit/3b6df64e180b982c8c97de9449b8ec55ee58bccf))
  * Update scripts headers ([Vlad - 5fdd7d0](https://github.com/vghn/puppet/commit/5fdd7d0eddd012e3a20430896132468ebf78486d))
  * Move CSR sign script to bin/ ([Vlad - 03cf172](https://github.com/vghn/puppet/commit/03cf172de3698ab8ab9fab63d8f7587357d18806))
  * Remove R10K post run hook ([Vlad - 7dc54c8](https://github.com/vghn/puppet/commit/7dc54c8906e671da87ab0dbce33db67eb07f2aab))
  * Move hieradata outside code ([Vlad - ba3e721](https://github.com/vghn/puppet/commit/ba3e7211e0c5f9e223129f1397af3f13b8f55ffc))
  * Update SSM command ([Vlad - 73fa7fc](https://github.com/vghn/puppet/commit/73fa7fc562decc17bf9b54409d8af775b284a584))
  * Add script to prepare the data container ([Vlad - 782a1dd](https://github.com/vghn/puppet/commit/782a1ddb0371109db6d5e3d7368025f6da0116c8))
  * Add script to run the centralized logging container ([Vlad - d2078db](https://github.com/vghn/puppet/commit/d2078db0a8d5b8996da16988c5a9aa6253ed0071))
  * Add script to run the puppet server ([Vlad - 5509e9d](https://github.com/vghn/puppet/commit/5509e9dedcb518f0a220bdd3b5fab946d408059d))
  * Add wait scripts ([Vlad - 6c4e0e0](https://github.com/vghn/puppet/commit/6c4e0e095b6ac7a7a4892ce83f0f0ca00047ff25))
  * Improve Docker Compose environment ([Vlad - f684dd4](https://github.com/vghn/puppet/commit/f684dd469ac670e2c23daf36c15a3881a5fc4e60))

## Version 0.0.43 / 2016-06-06
  * Update ssh module ([Vlad - 24ed049](https://github.com/vghn/puppet/commit/24ed04927a4802a31817c8fd44877d91dabae3db))
  * Remove unnecessary function ([Vlad - 8a5fa03](https://github.com/vghn/puppet/commit/8a5fa03608375b5e9c6ad57751f74389ba53cc0f))
  * Fix CSR signing script, and separate it from profile ([Vlad - d3b7643](https://github.com/vghn/puppet/commit/d3b7643ba8f8566fdbdcaa1dfc005e4e39b09f50))
  * Separate R10K from profile ([Vlad - 9cf50f7](https://github.com/vghn/puppet/commit/9cf50f7121fd1c98c7b89704b4b42c68148e4a1f))
  * Do not fail if role is not found ([Vlad - 26c86c1](https://github.com/vghn/puppet/commit/26c86c12f6086d0090d1693f5c891ac246638362))
  * Create Rhea role for the Puppet Master of Masters ([Vlad - e978605](https://github.com/vghn/puppet/commit/e978605defa7959d225cf35ab8fcf756ada6ad1a))
  * Create a Docker Compose environment ([Vlad - 6bc160a](https://github.com/vghn/puppet/commit/6bc160a25243c959b335929a7d38854604b1f6fe))

## Version 0.0.42 / 2016-06-04
  * Fix r10k deploy script ([Vlad - c879665](https://github.com/vghn/puppet/commit/c87966532b207dfac12f98aa05e628375424ede2))
  * Improve CSR Auto Sign script ([Vlad - 59fcf86](https://github.com/vghn/puppet/commit/59fcf86b9a8f11bb1d14a16b9fd8c3fcb71b81fd))

## Version 0.0.41 / 2016-06-03
  * Reorganize Roles/Profiles ([Vlad - a0074ed](https://github.com/vghn/puppet/commit/a0074eda31d14579e1a8abe1eda5c4a0221bea58))

## Version 0.0.40 / 2016-06-03
  * Fix zeus docker-compose.yaml ([Vlad - d1741fc](https://github.com/vghn/puppet/commit/d1741fc6a5fe3f2814d56c7a4be974cd68b3b93f))

## Version 0.0.39 / 2016-06-03
  * Fix scripts path creation ([Vlad - 5b943a0](https://github.com/vghn/puppet/commit/5b943a0aa71791830b26a8452146a41a5bb783b9))

## Version 0.0.38 / 2016-06-03
  * Fix scripts path creation ([Vlad - a5dc625](https://github.com/vghn/puppet/commit/a5dc6251eb8cb4c2e1b741c7ee5de16aaef5ef55))

## Version 0.0.37 / 2016-06-03
  * Ensure order ([Vlad - af95643](https://github.com/vghn/puppet/commit/af9564358307a2fdaebbe7bba5367a96ae0bb6c4))

## Version 0.0.36 / 2016-06-03
  *  Disable ENVTYPE cli overriding ([Vlad - 05b5796](https://github.com/vghn/puppet/commit/05b5796b0a1670fe2669c111c9cb20e28ab2c77b))
  * Make sure parent directories are present ([Vlad - 71d8acf](https://github.com/vghn/puppet/commit/71d8acf81bc4d85eb1723d161e75509aa6c63758))

## Version 0.0.35 / 2016-06-03
  * Use docker-compose to deploy R10K ([Vlad - e394ffb](https://github.com/vghn/puppet/commit/e394ffbeec01b859b6b5d2638dc031b2ded8e6f7))

## Version 0.0.34 / 2016-06-03
  * Move r10k post run hook and csr sign to roles/zeus ([Vlad - ff39354](https://github.com/vghn/puppet/commit/ff393544b8bb5086529a8e49c04a7a75cc39d3bc))

## Version 0.0.33 / 2016-06-02
  * Name R10K container ([Vlad - bd5db09](https://github.com/vghn/puppet/commit/bd5db09874935a24b9bec67ed4b94d4664016419))
  * Improve R10K post run hook ([Vlad - d25a0a5](https://github.com/vghn/puppet/commit/d25a0a54aeba0d0228a54362364a5b83ce5595a1))
  * Implement vladgh/common module ([Vlad - 772293b](https://github.com/vghn/puppet/commit/772293b01d0ab11b66eef37296f0795d71b9f1a3))

## Version 0.0.32 / 2016-06-02
  * Separate R10K from PuppetServer ([Vlad - 59f3d82](https://github.com/vghn/puppet/commit/59f3d82888d31840c15bce7db66e50aa80c121af))
  * Separate R10K from PuppetServer ([Vlad - 3bdb687](https://github.com/vghn/puppet/commit/3bdb6876dccb9a597ea0f5aeb22cae02d931f5da))
  * Fix AWS SSM command ([Vlad - 4ad4a76](https://github.com/vghn/puppet/commit/4ad4a76c68c4bce602bd4f8ae751b8e9c33a4009))

## Version 0.0.31 / 2016-06-01
  * Fix AWS SSM deploy command ([Vlad - 9124951](https://github.com/vghn/puppet/commit/9124951432206a6a277e175b1854dff59f7068b7))
  * Fix AWS SSM deploy command ([Vlad - 9fbd39e](https://github.com/vghn/puppet/commit/9fbd39ebfb58c6dece435ab7ed2f36fd571160c9))
  * Fix AWS SSM deploy command ([Vlad - 4d145dd](https://github.com/vghn/puppet/commit/4d145dd3c590e8c8ae68817361542cab8b3594a5))

## Version 0.0.30 / 2016-06-01
  * Remove unnecessary output ([Vlad - 2205483](https://github.com/vghn/puppet/commit/2205483b049330058f24cdb5bc29b6089c7fc17d))
  * Do not bind docker to ipaddress without TLS ([Vlad - 3d2d8a7](https://github.com/vghn/puppet/commit/3d2d8a752792af2fb4698da5fc6571be18e5bd7f))

## Version 0.0.29 / 2016-06-01
  * Use ENVTYPE to declare the environment ([Vlad - 8741b56](https://github.com/vghn/puppet/commit/8741b5680e82673444f4e002f336144f17af41e5))

## Version 0.0.28 / 2016-06-01
  * Fix environment ([Vlad - 0a9db20](https://github.com/vghn/puppet/commit/0a9db20ab902a7a5568cf231311a4c5af03e221a))

## Version 0.0.27 / 2016-06-01
  * Fix environment detection ([Vlad - 278d3c1](https://github.com/vghn/puppet/commit/278d3c174c71c6d024d5a2bbff4d9784135e2d0f))
  * Fix paths ([Vlad - 9d78f67](https://github.com/vghn/puppet/commit/9d78f67446bfda65bc273b8fa45a6fabca060102))

## Version 0.0.26 / 2016-06-01
  * Revert to R10K managing hieradata ([Vlad - 5bec79e](https://github.com/vghn/puppet/commit/5bec79e20f17823c9e451b47f835ea8e3a48a5d3))

## Version 0.0.25 / 2016-05-31
  * Allow bootstrap to specify waitforcert value ([Vlad - a48c774](https://github.com/vghn/puppet/commit/a48c7741f38e2951c67806552a4d314ab9e24019))

## Version 0.0.24 / 2016-05-31
  * Update documentation ([Vlad - 79bc446](https://github.com/vghn/puppet/commit/79bc4464f28e4f43de9bd68673aef4eb651a5e25))
  * Improve CSR script ([Vlad - f1c9f2a](https://github.com/vghn/puppet/commit/f1c9f2a00eadd45b955cabf72a84777cc510b4c3))

## Version 0.0.23 / 2016-05-30
  * Move r10k post run hook to /etc ([Vlad - a28335a](https://github.com/vghn/puppet/commit/a28335a7bf5015006e02dda0643b0547b120d58e))
  * Log r10k hook ([Vlad - 475bc63](https://github.com/vghn/puppet/commit/475bc6367f687bf73ba1aadb5a5e84504825bb3d))
  * Use require instead of include ([Vlad - 45e808d](https://github.com/vghn/puppet/commit/45e808dd6e5d404bba4a4977f4a914abbebe8f84))
  * Clean-up profile::puppet::master ([Vlad - 772810d](https://github.com/vghn/puppet/commit/772810d0d958924e0e5a7b312298e6945415a008))
  * Do not manage hiera and r10k in puppet ([Vlad - 684bc1d](https://github.com/vghn/puppet/commit/684bc1dfe322468c64e304cae74646dae7d7e3bd))
  * Fix acceptance tests ([Vlad - f906826](https://github.com/vghn/puppet/commit/f90682688da320778c9b82aad88dd54b38b7a339))
  * Add bootstrap option to retry in serverless mode ([Vlad - 599bcc0](https://github.com/vghn/puppet/commit/599bcc0a803ec3fea677342ac7a007b555acb488))
  * Fix bootstrap script ([Vlad - 2589afa](https://github.com/vghn/puppet/commit/2589afa747c081a063f86a5e85de9dad39254170))
  * Install rsync ([Vlad - 14191fd](https://github.com/vghn/puppet/commit/14191fda9f631b0581926e82d05a0743aaefef65))
  * Improve bootstrap ([Vlad - 58b2ea7](https://github.com/vghn/puppet/commit/58b2ea7cdaf7b4428aa55604bc77ec1d77f57897))
  * Fix bootstrap script ([Vlad - 1b2c7d1](https://github.com/vghn/puppet/commit/1b2c7d14138a7b7d85a28a3c7454ccdf45410429))
  * Improve push hook ([Vlad - 59b5d0d](https://github.com/vghn/puppet/commit/59b5d0dd79a344cc9f646084615de60049ed2a30))
  * Update README ([Vlad - 35412bd](https://github.com/vghn/puppet/commit/35412bd9074df2cb58c26e43b86a65fa74ec9f7c))
  * Switch to an approved Python puppet module ([Vlad - 0481610](https://github.com/vghn/puppet/commit/0481610cc27c51ce56a6bb33c196537df9dc4daa))
  * Improve docker compose file ([Vlad - 73483ab](https://github.com/vghn/puppet/commit/73483ab5b7541d9aaa0a43d9194fe036ae95c9c1))
  * Reorder resource declarations ([Vlad - f997906](https://github.com/vghn/puppet/commit/f997906ff7d46dac6d7f11cd8628d520660d679d))
  * Update README ([Vlad - 0e407ca](https://github.com/vghn/puppet/commit/0e407ca992584749a08fb151955661aa1ef6a7e8))

## Version 0.0.22 / 2016-05-24
  * Module updates ([Vlad - a6f7124](https://github.com/vghn/puppet/commit/a6f7124e5afd002b0e66c6d8baf516cbbdb4dd01))
  * Ensure latest git version ([Vlad - b722130](https://github.com/vghn/puppet/commit/b7221307f69b4f7274e51b60a3ca7cf79bfc658b))
  * Improve acceptance tests ([Vlad - e481344](https://github.com/vghn/puppet/commit/e481344bee4fd20eb0745230bb2a12b23a3c108e))
  * Fix hieradata path in acceptance tests ([Vlad - 18f4153](https://github.com/vghn/puppet/commit/18f415390f66be62cd720824c95b93012ccb5177))
  * Fix code style ([Vlad - c05a9b4](https://github.com/vghn/puppet/commit/c05a9b409598eb984626e86a4d3548944c9c907b))
  * Use the binary Ruby in Travis ([Vlad - 209118e](https://github.com/vghn/puppet/commit/209118e473fa0f50ff81e0fb165109a995385b06))
  * Fix testing fixtures config ([Vlad - cdc903f](https://github.com/vghn/puppet/commit/cdc903f78e7c6850de44bf6b12d64ee406dd76c2))
  * Improve acceptance tests ([Vlad - 6c90fb4](https://github.com/vghn/puppet/commit/6c90fb48254585df35a00c83718e6720c81876a3))
  * Add swap support ([Vlad - 18d1c19](https://github.com/vghn/puppet/commit/18d1c1946bd521d4964fa6c1d0547c2527a83352))

## Version 0.0.21 / 2016-05-21
  * Remove assets bucket mount point ([Vlad - 52b942d](https://github.com/vghn/puppet/commit/52b942d42a4c3d8be3f63f68f01fcf01e026e06c))

## Version 0.0.20 / 2016-05-20
  * Use the closest ruby version to the packaged one ([Vlad - 08c6372](https://github.com/vghn/puppet/commit/08c637271687e9503b4bf428d14eb0934e5865e7))
  * Fix typos ([Vlad - f0d5ba4](https://github.com/vghn/puppet/commit/f0d5ba4384e6b9bb925041c82c52ce706f144374))
  * Move hiera config to confdir ([Vlad - 734b596](https://github.com/vghn/puppet/commit/734b59671fcb80ae815d997a99a2613a15c95af4))
  * Clean-up acceptance tests ([Vlad - e5103ac](https://github.com/vghn/puppet/commit/e5103ac63602a32edfbf1e3c418be5ba918f7fc0))
  * Disable all puppet agent services ([Vlad - 51dfe6b](https://github.com/vghn/puppet/commit/51dfe6b7188e2926ef46ff7eabefc49df0f6c7c1))
  * Improve autosign logs ([Vlad - 0a660f5](https://github.com/vghn/puppet/commit/0a660f58b2b23b0ace7a98daff722b830171677d))
  * Allow regenerating ssl certificates during boostrap ([Vlad - 0f77a1f](https://github.com/vghn/puppet/commit/0f77a1f12b841d1c23fbf03ebad6cc500a74b780))

## Version 0.0.19 / 2016-05-19
  * Do not build on release branches ([Vlad - 8605e71](https://github.com/vghn/puppet/commit/8605e71c31deaf5598dd4d015410523f60997aac))

## Version 0.0.18 / 2016-05-19
  * Separate puppet control repo from infrastructure ([Vlad - a0492e4](https://github.com/vghn/puppet/commit/a0492e4465aedfcd07eef55978c8f7169830b5b4))
  * Fix aws-cli install ([Vlad - c7bb176](https://github.com/vghn/puppet/commit/c7bb176fec8c196ca0f9cf9418e97768a01d65cc))
  * Hiera should not be managed by puppet ([Vlad - 1474274](https://github.com/vghn/puppet/commit/1474274527f141d2ebab959d8f3e14bed3bd8774))
  * Update bootstrap ([Vlad - c96ecc2](https://github.com/vghn/puppet/commit/c96ecc21d78b4bbc37c26de71181aa7184e3b1c9))
  * Fix pre-commit hook ([Vlad - da5d20e](https://github.com/vghn/puppet/commit/da5d20e073326358cd3edeed93322b9bcd361919))
  * Minor changes in bootstrap script ([Vlad - 57f5c42](https://github.com/vghn/puppet/commit/57f5c42f461e270b09969cfdbab5d9a404ef3483))
  * Improve environment ([Vlad - 65f061b](https://github.com/vghn/puppet/commit/65f061bbdaff3d5013e0da16cfa211e83c689d20))
  * Fix ci install script ([Vlad - 44f8293](https://github.com/vghn/puppet/commit/44f8293ca890562aa3f63422afd51cb4b850c5e6))
  * Fix hieradata ([Vlad - 5860a34](https://github.com/vghn/puppet/commit/5860a34f6332648bccadcab10aecd04631385ab4))
  * Fix logging ([Vlad - d75442e](https://github.com/vghn/puppet/commit/d75442e3655e77f4e80276670745b9da79c11f89))
  * Fix logging ([Vlad - 74ffa85](https://github.com/vghn/puppet/commit/74ffa85a24d4e594811bf0e9757d9139f93529ce))
  * Clean-up code ([Vlad - 623e19f](https://github.com/vghn/puppet/commit/623e19fa3a0e0bddcb4ca2fccacabd1c70aa2bf6))
  * Separate the EC2 profile in multiple sub-profiles ([Vlad - e66d8e6](https://github.com/vghn/puppet/commit/e66d8e68e1630cf04ff28b63bec99acef20b4e42))
  * Remove old ec2 profile class ([Vlad - 2e0ed28](https://github.com/vghn/puppet/commit/2e0ed28ac80652251cb63528414f1aac8ca06438))
  * Deploy r10k after install ([Vlad - c17b133](https://github.com/vghn/puppet/commit/c17b133ec9ed79931c2f287b453b425b7e920d15))
  * Add htop to base packages ([Vlad - 33c21f9](https://github.com/vghn/puppet/commit/33c21f91dc478f8780522b3d22b9a0f501af8ecc))
  * Improve r10k deployment ([Vlad - 3258488](https://github.com/vghn/puppet/commit/32584883e948bd481bc761de92fd9195b4b2dad5))
  * Improve r10k deployment ([Vlad - 967d917](https://github.com/vghn/puppet/commit/967d9174697f155da5b2df9dd9560cf07d8dad6c))
  * Improve r10k deployment ([Vlad - 609e8ab](https://github.com/vghn/puppet/commit/609e8abeef8d09434feb7b87d19b9a65c03b1d7b))
  * Add s3fs profile ([Vlad - bb37d45](https://github.com/vghn/puppet/commit/bb37d4567431d4e84326c65f73943938eb0f02b9))
  * Fix s3fs mount point ([Vlad - c75b49d](https://github.com/vghn/puppet/commit/c75b49dca7edff3092df2f8cb485958c2a067b39))
  * Improve docker container declaration ([Vlad - e1372ff](https://github.com/vghn/puppet/commit/e1372fffda5ba0d67334a985b98dcf1c9350ec42))
  * Bring back changes log and version files ([Vlad - 4985893](https://github.com/vghn/puppet/commit/4985893a546ee6656dec1fe5d009271c10f9653c))

## Version 0.0.17 / 2016-05-10
  * Use the trusted certname fact for agent cron job ([Vlad - 743eb2e](https://github.com/vghn/puppet/commit/743eb2e41c61d5204d40e4f6125c2fa098e516fb))

## Version 0.0.16 / 2016-05-10
  * Update README ([Vlad - 19626ca](https://github.com/vghn/puppet/commit/19626caf82795e6a9a362aedec607f7375d27b30))

## Version 0.0.15 / 2016-05-10
  * Use sha for version patch ([Vlad - d9790ed](https://github.com/vghn/puppet/commit/d9790ed2aac23bf99eac115bd5d3d8cb9dfa4053))

## Version 0.0.14 / 2016-05-10
  * Remove version from the stack parameters ([Vlad - 3bfc726](https://github.com/vghn/puppet/commit/3bfc726db04f9af4a16f254e2049d94330d4f6d3))

## Version 0.0.13 / 2016-05-10
  * Do not update CloudFormation on every build ([Vlad - 200d952](https://github.com/vghn/puppet/commit/200d95269d1cccddacf86f304622ee17b713a907))

## Version 0.0.12 / 2016-05-10
  * Add bash checks for desired capacities ([Vlad - 30a5446](https://github.com/vghn/puppet/commit/30a5446a5de2b3a3db6a2d2d26e147391e3861ee))

## Version 0.0.11 / 2016-05-10
  * Read the existing asg and ecs capacities ([Vlad - 43c3c8e](https://github.com/vghn/puppet/commit/43c3c8ecf9dc04ece9134f67fe0acaf975cd352b))

## Version 0.0.10 / 2016-05-10
  * Separate CI User ([Vlad - 5b94209](https://github.com/vghn/puppet/commit/5b94209f72e5cecb527b90404fbd2e81ff5da81e))

## Version 0.0.9 / 2016-05-10
  * Improve CI IAM user ([Vlad - a5eb582](https://github.com/vghn/puppet/commit/a5eb58298d41a62439719cabb422ef309de2e536))
  * Allow CI to update CloudFormation template ([Vlad - 373b51f](https://github.com/vghn/puppet/commit/373b51f1184927bfc17241bf9aba572f13eea8f1))
  * Fix typo ([Vlad - 46436a2](https://github.com/vghn/puppet/commit/46436a2d4fd1c3cc39f7932c152eb4c6ef63cab7))

## Version 0.0.8 / 2016-05-09
  * Fix ami tests ([Vlad - 30aae0e](https://github.com/vghn/puppet/commit/30aae0e010a5cfb7548401fabefe6269f8d5e5b2))
  * Consolidate all functions under lib/ ([Vlad - 4aa7db5](https://github.com/vghn/puppet/commit/4aa7db51e08336bf75167a3bf3af3579a59f6cf7))
  * Fix scripts ([Vlad - a0a13fb](https://github.com/vghn/puppet/commit/a0a13fb866d92d5aba6976ea1113242ad5307c58))
  * Use the current branch when creating an image ([Vlad - c8ce9c5](https://github.com/vghn/puppet/commit/c8ce9c5f0ecd22f8d8896b45f5ac1d3e77ca0082))
  * Fix image tests ([Vlad - 38bcd32](https://github.com/vghn/puppet/commit/38bcd328742b6d6b3be4be3f96e69b09668890a6))
  * Change ca sync agent arguments ([Vlad - b28c896](https://github.com/vghn/puppet/commit/b28c896445fb53cef40d5e550c3f852fbb4f166a))
  * Improve autosign policy scripts ([Vlad - c423598](https://github.com/vghn/puppet/commit/c4235987689f3170fa5f916d8a218f45d8d8c44d))
  * Fix syntax ([Vlad - 760fa7d](https://github.com/vghn/puppet/commit/760fa7da682976f9eddda3030c2804d8efa8b557))
  * Improve code readability ([Vlad - f027a8d](https://github.com/vghn/puppet/commit/f027a8d6da580820baf11608f738b0411cee1dd2))
  * No need to create ecs directorie in puppet ([Vlad - 15458d9](https://github.com/vghn/puppet/commit/15458d930650efbdc12c7398c37a2cd6ab2e88ae))
  * Update apt first during bootstrap ([Vlad - 3215c7f](https://github.com/vghn/puppet/commit/3215c7f4ee76ac3847b2cd70070cf87a47728cac))
  * Allow tests to use private or public data ([Vlad - 9853b3b](https://github.com/vghn/puppet/commit/9853b3b931183836617d2b47ef7a87164ff925df))
  * Parameterize asg desired capacity and ecs desired count ([Vlad - e603673](https://github.com/vghn/puppet/commit/e6036735caeb05078adef7be302d9622eb5ae44f))

## Version 0.0.7 / 2016-05-04
  * Add extra log files from hiera ([Vlad - 3ef49ec](https://github.com/vghn/puppet/commit/3ef49ec2ada92f77887612d475e99544bc267757))
  * Add sudo to r10k deploy ec2 run command ([Vlad - 81dea52](https://github.com/vghn/puppet/commit/81dea529d0de887ae202f77adb93a2dc6307ef75))
  * Separate R10K deployment from the Puppet run ([Vlad - 5f8892c](https://github.com/vghn/puppet/commit/5f8892c4d38ab926c751cab5d2af259241d4f1ae))
  * Improve puppet run cron on agent ([Vlad - 83c1020](https://github.com/vghn/puppet/commit/83c1020f1ef2685d28540c082168cafc20c389c0))
  * Improve testing ([Vlad - 0998c0a](https://github.com/vghn/puppet/commit/0998c0a9b059fdf5df4297303fd2a0363f30ebd2))

## Version 0.0.6 / 2016-05-01
  * Add logging container ([Vlad - 199b80c](https://github.com/vghn/puppet/commit/199b80c58db22fa1fedfed78b232fda62986c448))

## Version 0.0.5 / 2016-05-01
  * Add puppet module dependecies ([Vlad - b05bbaf](https://github.com/vghn/puppet/commit/b05bbaf062499d0aa7ca8ddfa2b87e8572829dd3))
  * Add hostnames on containers for logging purposes ([Vlad - 751fcc9](https://github.com/vghn/puppet/commit/751fcc9a2f6c000000fbd4783573c0424e8aa64a))
  * Add rsyslog module and clean tests ([Vlad - a6ab2da](https://github.com/vghn/puppet/commit/a6ab2da86c9bbb19829cdc9baa6d678c7d63f30b))
  * Add sudo to cron job ([Vlad - 853920d](https://github.com/vghn/puppet/commit/853920dd1236240dce7ff09af3e7186b8a778d4b))
  * Clean-up gitignore ([Vlad - f79a3e1](https://github.com/vghn/puppet/commit/f79a3e1263be1cde7e6c19fd28db382178d8050f))

## Version 0.0.4 / 2016-04-29
  * Change the location of the container info in ECS ([Vlad - b5791c5](https://github.com/vghn/puppet/commit/b5791c5399d85aa1e9174998b92e5e7fd43cad69))

## Version 0.0.3 / 2016-04-28
  * Remove Lambda functions from CloudFormation ([Vlad - 21f928a](https://github.com/vghn/puppet/commit/21f928a7278274435f480f717e93c5b0383635e4))

## Version 0.0.2 / 2016-04-28
  * Fix permissions on puppet ssl dir ([Vlad - acbedb5](https://github.com/vghn/puppet/commit/acbedb595185c2a86df6de4c7d87adf822002c90))
  * Separate the certificate sync agent from ECS ([Vlad - 283afd1](https://github.com/vghn/puppet/commit/283afd1b836e8268dbdc35b9178b5c7fd9e9ea62))
  * Changed default desired count to 1 ([Vlad - 8b52c5c](https://github.com/vghn/puppet/commit/8b52c5cb25983067bae592e84d4980b7cb226567))

## Version 0.0.1 / 2016-04-27
  * Initial release
