# Debian Package - Mongo Express [![Build Status](https://travis-ci.org/manala/debian-package-mongo-express.svg?branch=master)](https://travis-ci.org/manala/debian-package-mongo-express)

:exclamation: [Report issues](https://github.com/manala/debian-packages/issues) and [send Pull Requests](https://github.com/manala/debian-packages/pulls) in the [main Debian Packages repository](https://github.com/manala/debian-packages) :exclamation:

Provides [Mongo Express](https://github.com/mongo-express/mongo-express) debian package.

## Build

Build for all enabled debian distributions

```
$ make build
```

Build for a specific enabled debian distribution

```
$ make build.wheezy
$ make build.jessie
$ make build.stretch
…
```

## Update

* Check for new versions on https://www.npmjs.com/package/mongo-express
* Update "PACKAGE_VERSION" accordingly in Makefile
* Add an entry to debian/[distribution]/changelog (use "date --rfc-2822 -u" command to specify date)
