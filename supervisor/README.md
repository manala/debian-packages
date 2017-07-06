# Debian Package - Supervisor [![Build Status](https://travis-ci.org/manala/debian-package-supervisor.svg?branch=master)](https://travis-ci.org/manala/debian-package-supervisor)

:exclamation: [Report issues](https://github.com/manala/debian-packages/issues) and [send Pull Requests](https://github.com/manala/debian-packages/pulls) in the [main Debian Packages repository](https://github.com/manala/debian-packages) :exclamation:

Provides [Supervisor](http://supervisord.org/) debian package.

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

* Check for new versions on http://snapshot.debian.org/package/supervisor/
* Update "PACKAGE_*" variables accordingly in Makefile
