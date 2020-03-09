# Debian Package - Sensu-go-agent [![Build Status](https://travis-ci.org/manala/debian-package-sensu-go-agent.svg?branch=master)](https://travis-ci.org/manala/debian-package-sensu-go-agent)

:exclamation: [Report issues](https://github.com/manala/debian-packages/issues) and [send Pull Requests](https://github.com/manala/debian-packages/pulls) in the [main Debian Packages repository](https://github.com/manala/debian-packages) :exclamation:

Provides [Sensu-go-agent](https://www.sensu.io/) debian package.

## Build

Build for all enabled debian distributions

```
$ make build
```

Build for a specific enabled debian distribution

```
$ make build.jessie
$ make build.stretch
…
```

## Update

* Check for new versions on https://github.com/sensu/sensu-go/releases
* Update "PACKAGE_VERSION" accordingly in Makefile
* Add an entry to debian/[distribution]/changelog (use "date --rfc-2822 -u" command to specify date)
