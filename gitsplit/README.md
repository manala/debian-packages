# Debian Package - Gitsplit [![Build Status](https://travis-ci.org/manala/debian-package-gitsplit.svg?branch=master)](https://travis-ci.org/manala/debian-package-gitsplit)

:exclamation: [Report issues](https://github.com/manala/debian-packages/issues) and [send Pull Requests](https://github.com/manala/debian-packages/pulls) in the [main Debian Packages repository](https://github.com/manala/debian-packages) :exclamation:

Provides [Gitsplit](https://github.com/jderusse/docker-gitsplit) debian package.

## Build

Build for all enabled debian distributions

```
$ make build-all
```

Build for a specific enabled debian distribution

```
$ make build.wheezy
$ make build.jessie
$ make build.stretch
…
```

## Update

* Check for new commits on https://github.com/jderusse/docker-gitsplit/commits/master
* Update "PACKAGE_VERSION" accordingly in Makefile
* Add an entry to debian/[distribution]/changelog (use "date --rfc-2822 -u" command to specify date)
