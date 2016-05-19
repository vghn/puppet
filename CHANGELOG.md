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
