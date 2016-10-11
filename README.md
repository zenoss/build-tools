# build-tools
Docker image with build tools needed by zenoss.

# Docker Images
There are two docker images produced by this repo:
* `zenoss/build-tools:<version>` - This is the primary image used by a variety of projects. 
* `zenoss/build-tools:<version>-jenkins` - The same as `zenoss/build-tools:<version>` plus the necessary additions to be used as a jenkins slave.


# Building
To buid a dev images for testing locally, use
  * `git checkout develop`
  * `git pull origin develop`
  * `make clean build`

The result should be a `n.n.n-dev` image in your local docker repo (e.g. `1.1.1-dev`).   If you need to make changes, create
a feature branch like you would for any other kind of change, modify the image definition as necessary, use `make clean build` to
build an image and then test it as necessary.   Once you have finished your local testing, commit your changes, push them,
and create a pull-request as you would normally. A Jenkins PR build will be started to verify that your changes will build in
a Jenkins environment.

# Releasing

Use git flow to release a version to the `master` branch.

The image version is defined in the [makefile](.makefile).

For Zenoss employees, the details on using git-flow to release a version is documented on the Zenoss Engineering [web site](https://sites.google.com/a/zenoss.com/engineering/home/faq/developer-patterns/using-git-flow).
 After the git flow process is complete, a jenkins job can be triggered manually to build and 
 publish the images to docker hub. 


